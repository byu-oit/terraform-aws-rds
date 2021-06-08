provider "aws" {
  version = "~> 3.0"
  region  = "us-west-2"
}

module "acs" {
  source = "github.com/byu-oit/terraform-aws-acs-info.git?ref=v3.0.0"
}

module "rds" {
  source = "github.com/byu-oit/terraform-aws-rds?ref=v2.3.2"
  //  source                  = "../.."
  identifier              = "example"
  engine                  = "mysql"
  engine_version          = "8.0"
  family                  = "mysql8.0"
  cloudwatch_logs_exports = ["error", "general", "slowquery"]

  db_name           = "example"
  subnet_ids        = module.acs.data_subnet_ids
  subnet_group_name = module.acs.db_subnet_group_name
  vpc_id            = module.acs.vpc.id

  parameter_group_parameters = {
    autocommit            = "1"
    innodb_file_per_table = "1"
  }

  deletion_protection = true
}
