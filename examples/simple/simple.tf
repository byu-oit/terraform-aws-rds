provider "aws" {
  version = "~> 2.42"
  region  = "us-west-2"
}

module "acs" {
  source = "github.com/byu-oit/terraform-aws-acs-info.git?ref=v2.1.0"
}

module "rds" {
  //  source = "github.com/byu-oit/terraform-aws-rds?ref=v0.3.0"
  source                  = "../.."
  identifier              = "example"
  engine                  = "mysql"
  engine_version          = "8.0"
  cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  db_name           = "example"
  subnet_ids        = module.acs.data_subnet_ids
  subnet_group_name = module.acs.db_subnet_group_name
  vpc_id            = module.acs.vpc.id

  deletion_protection = true
}
