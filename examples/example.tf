provider "aws" {
  version = "~> 2.42"
  region  = "us-west-2"
}

module "acs" {
  source = "git@github.com:byu-oit/terraform-aws-acs-info.git?ref=v1.2.0"
  env = "dev"
}

module "rds" {
  source = "git@github.com:byu-oit/terraform-aws-rds?ref=v0.1.0"
//  source = "../"
  identifier = "example"
  engine = "mysql"
  engine_version = "8.0"

  db_name = "example"
  subnet_ids = module.acs.data_subnet_ids
  vpc_id = module.acs.vpc.id

  deletion_protection = false
}
