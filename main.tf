terraform {
  required_version = ">= 0.12.16"
  required_providers {
    aws = ">= 2.42"
  }
}

resource "aws_db_instance" "database" {
  username                  = var.db_username
  password                  = var.db_password
  identifier                = var.instance_name
  engine                    = var.db_engine
  instance_class            = var.instance_class
  name                      = var.db_name
  allocated_storage         = var.db_storage
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_name != "" ? var.final_snapshot_name : "${var.instance_name}-final-snapshot"
  db_subnet_group_name      = var.db_subnet_group
}

