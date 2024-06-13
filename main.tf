terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

locals {
  ssm_prefix                        = var.ssm_prefix != null ? var.ssm_prefix : "/${var.identifier}"
  mysql_default_group_parameters    = var.engine == "mysql" ? { require_secure_transport = "1" /* Forces SSL */ } : {}
  postgres_default_group_parameters = var.engine == "postgres" ? { "rds.force_ssl" = "1" /* Forces SSL */ } : {}
  parameter_group_parameters        = merge(local.mysql_default_group_parameters, local.postgres_default_group_parameters, var.parameter_group_parameters)
}

resource "random_password" "default" {
  count   = var.master_password == null ? 1 : 0
  length  = 32
  special = false
  keepers = {
    recreate_password = false
  }
}
resource "random_string" "default" {
  count   = var.master_username == null ? 1 : 0
  length  = 16
  special = false
  numeric = false
  keepers = {
    recreate_username = false
  }
}
resource "aws_ssm_parameter" "master_username" {
  name        = "${local.ssm_prefix}/master_username"
  description = "${var.identifier} Database master username"
  type        = "String"
  value       = var.master_username != null ? var.master_username : random_string.default[0].result
  tags        = var.tags
}
resource "aws_ssm_parameter" "master_password" {
  name        = "${local.ssm_prefix}/master_password"
  description = "${var.identifier} Database master password"
  type        = "SecureString"
  value       = var.master_password != null ? var.master_password : random_password.default[0].result
  tags        = var.tags
}

resource "aws_security_group" "db_security_group" {
  name        = var.db_security_group_name != null ? var.db_security_group_name : "${var.identifier}-db_sg"
  description = "Security group for ${var.identifier} RDS instance"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_db_instance" "database" {
  identifier           = var.identifier
  instance_class       = var.instance_class
  engine               = var.engine
  engine_version       = var.engine_version
  parameter_group_name = aws_db_parameter_group.parameter_group.name

  db_name                             = var.db_name
  username                            = var.master_username != null ? var.master_username : aws_ssm_parameter.master_username.value
  password                            = var.master_password != null ? var.master_password : aws_ssm_parameter.master_password.value
  allocated_storage                   = var.allocated_storage
  max_allocated_storage               = var.max_allocated_storage
  storage_type                        = var.storage_type
  storage_encrypted                   = var.storage_encrypted
  deletion_protection                 = var.deletion_protection
  enabled_cloudwatch_logs_exports     = var.cloudwatch_logs_exports
  backup_retention_period             = var.backup_retention_period
  backup_window                       = var.backup_window
  maintenance_window                  = var.maintenance_window
  multi_az                            = var.multi_az
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  ca_cert_identifier                  = var.ca_cert_identifier

  db_subnet_group_name   = var.subnet_group_name
  vpc_security_group_ids = concat(var.security_group_ids, [aws_security_group.db_security_group.id])

  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = "${var.identifier}-final-snapshot"
  copy_tags_to_snapshot     = true

  performance_insights_enabled          = var.performance_insights != null # If the object exists then turn on
  performance_insights_retention_period = var.performance_insights != null ? var.performance_insights.retention_period_days : null

  tags = var.tags

  depends_on = [
    aws_cloudwatch_log_group.db_logs
  ]

  lifecycle {
    ignore_changes = [engine_version]
  }
}

resource "aws_db_parameter_group" "parameter_group" {
  name   = var.identifier
  family = var.family

  dynamic "parameter" {
    for_each = local.parameter_group_parameters
    content {
      name  = parameter.key
      value = parameter.value
    }
  }

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "db_logs" {
  for_each          = toset(var.cloudwatch_logs_exports)
  name              = "/aws/rds/instance/${var.identifier}/${each.value}"
  retention_in_days = var.log_retention_in_days
  tags              = var.tags
}
