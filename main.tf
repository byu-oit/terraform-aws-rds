terraform {
  required_version = ">= 0.12.16"
  required_providers {
    aws = ">= 2.42"
  }
}

module "terraform-aws-rds" {
  source = "git@github.com:byu-oit/terrafrom-aws-rds"

  resource "aws_db_instance" "database" {
    username = var.username
    password = var.password
    identifier = var.instance_name
    engine = var.db_engine
    
  }
}

