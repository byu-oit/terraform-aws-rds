terraform {
  required_version = "1.2.0"
}

provider "aws" {
  version = "~> 4.0"
  region  = "us-west-2"
}

module "acs" {
  source = "github.com/byu-oit/terraform-aws-acs-info.git?ref=v4.0.0"
}

module "rds" {
  source                  = "../.."
  identifier              = "example"
  engine                  = "mysql"
  engine_version          = "8.0"
  family                  = "mysql8.0"
  cloudwatch_logs_exports = ["error", "general", "slowquery"]

  db_name           = "example"
  subnet_ids        = module.acs.data_subnet_ids
  subnet_group_name = module.acs.db_subnet_group_name
  vpc_id            = module.acs.vpc.id

  deletion_protection = true
}

output "instance" {
  value = module.rds.instance
}

output "security_group" {
  value = module.rds.security_group
}

output "master_username_parameter" {
  value = module.rds.master_username_parameter
}

output "master_password_parameter" {
  value = module.rds.master_password_parameter
}
