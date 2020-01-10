![Latest GitHub Release](https://img.shields.io/github/v/release/byu-oit/terraform-aws-<module_name>?sort=semver)

# Terraform AWS RDS
This terraform deploys an RDS instance.
 
## Usage
```hcl
module "rds" {
  source = "git@github.com:byu-oit/terraform-aws-rds?ref=v0.1.0"

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
| `identifier` | string | **Required** Identifier for the RDS instance | |
| `instance_class` | string | The instance class the RDS instance will use | db.t2.micro |
| `engine` | string | **Required** The database engine the RDS instance will use | |
| `engine_version` | string | **Required** The engine version to use | |
| `db_name` | string | The name of the database that RDS will create | |
| `master_username` | string | **Required** The master username to be used for the RDS instance | |
| `master_password` | string | **Required** The master password to be used for the RDS instnace | |
| `allocated_storaged` | number | The amount of storage to be allocated for the database | 20 |
| `storage_type` | string | Storage type for the database [standard, gp2] | gp2  |
| `storage_encrypted` | bool | Specifies whether the DB instance is encrypted | true |
| `vpc_id` | string | **Required** VPC ID to put the RDS instance on | |
| `subnet_ids` | list(string) | **Required** A list of VPC subnet IDs to put the RDS instance on | |
| `deletion_protection` | bool | If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true | true |
| `skip_final_snapshot` | boolean | If set to true, no final snapshot of the database will be made when its deleted. | false |

## Outputs
| Name | Type | Description |
| ---  | ---  | --- |
| `instance` | [object]() | The RDS Instance object |
| `security_group` | [object]() | The security group for the RDS Instance |
| `master_username_parameter` | [object]() | SSM parameter object of the RDS database master username |
| `master_password_parameter` | [object]() | SSM parameter object of the RDS database password | |