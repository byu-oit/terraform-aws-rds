terraform {
  required_version = ">= 0.12.16"
  required_providers {
    aws = ">= 2.42"
  }
}

resource "random_password" "default" {
  count   = var.master_password == null ? 1 : 0
  length  = 32
  special = false
  keepers = {
    recreate_password = false
  }
}
resource "aws_ssm_parameter" "master_username" {
  name        = "/${var.identifier}/master_username"
  description = "${var.identifier} Database master username"
  type        = "String"
  value       = var.master_username != null ? var.master_username : "${var.identifier}_root"
  tags        = var.tags
}
resource "aws_ssm_parameter" "master_password" {
  name        = "/${var.identifier}/master_password"
  description = "${var.identifier} Database master password"
  type        = "SecureString"
  value       = var.master_password != null ? var.master_password : random_password.default[0].result
  tags        = var.tags
}

resource "aws_security_group" "db_security_group" {
  name        = "${var.identifier}-db_sg"
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

  name                            = var.db_name
  username                        = var.master_username != null ? var.master_username : aws_ssm_parameter.master_username.value
  password                        = var.master_password != null ? var.master_password : aws_ssm_parameter.master_password.value
  allocated_storage               = var.allocated_storage
  storage_type                    = var.storage_type
  storage_encrypted               = var.storage_encrypted
  deletion_protection             = var.deletion_protection
  enabled_cloudwatch_logs_exports = var.cloudwatch_logs_exports
  backup_retention_period         = var.backup_retention_period
  backup_window                   = var.backup_window
  maintenance_window              = var.maintenance_window

  db_subnet_group_name   = var.subnet_group_name
  vpc_security_group_ids = concat(var.security_group_ids, [aws_security_group.db_security_group.id])

  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = "${var.identifier}-final-snapshot"
  copy_tags_to_snapshot     = true

  tags = var.tags
}

resource "aws_db_parameter_group" "parameter_group" {
  name   = var.identifier
  family = var.family

  dynamic "parameter" {
    for_each = var.parameter_group_parameters
    content {
      name  = parameter.key
      value = parameter.value
    }
  }

  tags = var.tags
}