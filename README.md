![Latest GitHub Release](https://img.shields.io/github/v/release/byu-oit/terraform-aws-<module_name>?sort=semver)

# Terraform AWS RDS
This terraform deploys an RDS instance.
 
## Usage
```hcl
module "rds" {
  source = "git@github.com:byu-oit/terraform-aws-rds?ref=v1.0.0"

  db_username    = "username"
  db_password    = "password"
  db_engine      = "mysql"
  db_name        = "some_db"
  instance_name  = "rds_name"
  instance_class = "db.t2.micro"
}
```

## Requirements
* Terraform version 0.12.16 or greater

## Inputs
| Name | Type  | Description | Default |
| --- | --- | --- | --- |
| db_username | string | **Required** The master username to be used for the RDS instance | |
| db_password | string | **Required** The master password to be used for the RDS instnace | |
| db_engine | string | **Required** The database engine the RDS instance will use | |
| db_name | string | The name of the database that RDS will create | default |
| instance_name | string | **Required** The actual name of the RDS instance | |
| instance_class | string | The instance class the RDS instance will use | db.t2.micro |

## Outputs
| Name | Type | Description |
| ---  | ---  | --- |
| | | |
