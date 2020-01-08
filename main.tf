terraform {
  required_version = ">= 0.12.16"
  required_providers {
    aws = ">= 2.42"
  }
}

data "aws_region" "current" {}

resource "aws_db_instance" "database" {
  username       = var.db_username
  password       = var.db_password
  identifier     = var.db_identifier
  engine         = var.db_engine
  instance_class = var.db_instance_class
  region         = data.aws_region.current.name

}

