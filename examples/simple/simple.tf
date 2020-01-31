provider "aws" {
  version = "~> 2.42"
  region  = "us-west-2"
}

module "acs" {
  source = "github.com/byu-oit/terraform-aws-acs-info.git?ref=v1.2.2"
  env    = "dev"
}

module "rds" {
  //  source = "github.com/byu-oit/terraform-aws-rds?ref=v0.2.0"
  source         = "../.."
  identifier     = "example"
  engine         = "mysql"
  engine_version = "8.0"

  db_name           = "example"
  subnet_ids        = module.acs.data_subnet_ids
  subnet_group_name = module.acs.db_subnet_group_name
  vpc_id            = module.acs.vpc.id

  deletion_protection = true
}
