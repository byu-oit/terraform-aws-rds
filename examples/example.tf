provider "aws" {
  version = "~> 2.42"
  region  = "us-west-2"
}

module "rds" {
  source = "git@github.com:byu-oit/terraform-aws-rds?ref=v1.0.0"

  db_username    = "user"
  db_password    = "password"
  db_name        = "some_db"
  instance_name  = "rds_name"
  db_engine      = "mysql"
  instance_class = "db.t2.micro"
}
