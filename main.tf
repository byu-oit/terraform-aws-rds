terraform {
  required_version = ">= 0.12.16"
  required_providers {
    aws = ">= 2.42"
  }
}

resource "aws_db_instance" "database" {
  username       = var.rds_username
  password       = var.rds_password
  identifier     = var.rds_instance_name
  engine         = var.rds_engine
  instance_class = var.rds_instance_class
  name           = var.rds_db_name
}

