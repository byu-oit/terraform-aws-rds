provider "aws" {
  version = "~> 2.42"
  region  = "us-west-2"
}

module "rds" {
  source = "git@github.com:byu-oit/terraform-aws-rds?ref=v1.0.0"


}
