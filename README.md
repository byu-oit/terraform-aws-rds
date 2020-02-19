![Latest GitHub Release](https://img.shields.io/github/v/release/byu-oit/terraform-aws-rds?sort=semver)

# Terraform AWS RDS
This terraform deploys an RDS instance.
 
## Usage
```hcl
module "rds" {
  source = "github.com/byu-oit/terraform-aws-rds?ref=v0.3.0"

  identifier     = "example"
  engine         = "mysql"
  engine_version = "8.0"

  db_name           = "example"
  subnet_ids        = module.acs.data_subnet_ids
  subnet_group_name = module.acs.db_subnet_group_name
  vpc_id            = module.acs.vpc.id
}
```

## Requirements
* Terraform version 0.12.16 or greater

## Inputs
| Name | Type  | Description | Default |
| --- | --- | --- | --- |
| `identifier` | string | Identifier for the RDS instance | |
| `instance_class` | string | The instance class the RDS instance will use | db.t2.micro |
| `engine` | string | The database engine the RDS instance will use | |
| `engine_version` | string | The engine version to use | |
| `db_name` | string | The name of the database that RDS will create | |
| `master_username` | string | The master username to be used for the RDS instance. If not provided, a random one will be generated (see [below](#master_usernamemaster_password)).| null |
| `master_password` | string | The master password to be used for the RDS instnace. If not provided, a random one will be generated (see [below](#master_usernamemaster_password)). | null |
| `allocated_storaged` | number | The amount of storage to be allocated for the database | 32 |
| `storage_type` | string | Storage type for the database [standard, gp2] | gp2  |
| `storage_encrypted` | bool | Specifies whether the DB instance is encrypted | true |
| `vpc_id` | string | VPC ID to put the RDS instance on | |
| `subnet_ids` | list(string) | A list of VPC subnet IDs to put the RDS instance on | |
| `subnet_group_name` | string | Database subnet group name (can be retrieved from acs-info) | |
| `deletion_protection` | bool | If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true | true |
| `skip_final_snapshot` | boolean | If set to true, no final snapshot of the database will be made when its deleted. | false |
| `cloudwatch_logs_exports` | list(string) | List of log types to enable for exporting to CloudWatch logs. Each engine has different valid values | ['audit', 'error', 'general', 'slowquery'] |
| `backup_retention_period` | number | The days to retain backups for. Must be between 0 and 35. Must be greater than 0 if the database is used as a source for a Read Replica. | 7 |
| `backup_window` | string | The daily time range (in UTC) during which automated backups are created if they are enabled. Syntax: "hh24:mi-hh24:mi". Eg: "09:46-10:16". Must not overlap with maintenance_window. | 07:01-07:31 (this is either midnight or 1am Mountain Time, depending on daylight savings) |
| `maintenance_window` | string | The window to perform maintenance in. Syntax: "ddd:hh24:mi-ddd:hh24:mi". Eg: "Mon:00:00-Mon:03:00". | null |
| `tags` | map(string) | A map of AWS Tags to attach to each resource created | {} |

#### master_username/master_password
You can provide your own username and password, but please **DO NOT COMMIT** your password to source code.

If you do not provide your own `master_username` or `master_password` then this module will create a random one for you.

In both cases the username and passwords will be stored in SSM Parameter store and available via [outputs](#outputs).

## Outputs
| Name | Type | Description |
| ---  | ---  | --- |
| `instance` | [object](https://www.terraform.io/docs/providers/aws/r/db_instance.html#attributes-reference) | The RDS Instance object |
| `security_group` | [object](https://www.terraform.io/docs/providers/aws/r/security_group.html#attributes-reference) | The security group for the RDS Instance |
| `master_username_parameter` | [object](https://www.terraform.io/docs/providers/aws/r/ssm_parameter.html#attributes-reference) | SSM parameter object of the RDS database master username |
| `master_password_parameter` | [object](https://www.terraform.io/docs/providers/aws/r/ssm_parameter.html#attributes-reference) | SSM parameter object of the RDS database password | |
