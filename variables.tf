variable "identifier" {
  type        = string
  description = "Identifier for the DB Instance"
}
variable "instance_class" {
  type        = string
  description = "The instance type to use for the database"
  default     = "db.t3.small"
}
variable "engine" {
  type        = string
  description = "The engine to be used for the database"
}
variable "engine_version" {
  type        = string
  description = "The engine version to use."
}
variable "family" {
  type        = string
  description = "The family of the DB parameter group."
}

variable "db_name" {
  type        = string
  description = "The name for a database to be created in the RDS instance."
  default     = null
}
variable "ssm_prefix" {
  type        = string
  description = "The SSM Parameter Store Prefix to use when creating the master username and password."
  default     = null
}
variable "master_username" {
  type        = string
  description = "Master username for the database instance."
  default     = null
}
variable "master_password" {
  type        = string
  description = "Password for the master username"
  default     = null
}
variable "allocated_storage" {
  type        = number
  description = "The amount of storage to be allocated for the database"
  default     = 32
}
variable "max_allocated_storage" {
  type        = number
  description = "The max amount of storage for the database. Used for storage autoscaling."
  default     = null
}
variable "storage_type" {
  type        = string
  description = "Storage type for the database. 'standard' (magnetic) or 'gp2' (general purpose SSD). Defaults to gp2"
  default     = "gp2"
}
variable "storage_encrypted" {
  type        = bool
  description = "Specifies whether the DB instance is encrypted. Defaults to true."
  default     = true
}
variable "vpc_id" {
  type        = string
  description = "VPC ID to put the RDS instance on."
}
variable "subnet_ids" {
  type        = list(string)
  description = "A list of VPC subnet IDs to put the RDS instance on."
}
variable "subnet_group_name" {
  type        = string
  description = "Subnet group name"
}
variable "deletion_protection" {
  type        = bool
  description = "If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is true"
  default     = true
}
variable "skip_final_snapshot" {
  type        = bool
  description = "If true, skips final snapshot on destroy."
  default     = false
}
variable "cloudwatch_logs_exports" {
  type        = list(string)
  description = "List of log types to enable for exporting to CloudWatch logs. Each engine has different valid values. We strongly recommend adding the 'audit' log where possible."
}
variable "log_retention_in_days" {
  type        = number
  description = "CloudWatch log groups retention in days. Defaults to 120."
  default     = 120
}
variable "backup_retention_period" {
  type        = number
  description = "The days to retain backups for. Must be between 0 and 35. Must be greater than 0 if the database is used as a source for a Read Replica."
  default     = 7
}
variable "backup_window" {
  type        = string
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: \"09:46-10:16\". Must not overlap with maintenance_window."
  default     = "07:01-07:31" #midnight or 1am depending on daylight savings
}
variable "maintenance_window" {
  type        = string
  description = "The window to perform maintenance in. Syntax: \"ddd:hh24:mi-ddd:hh24:mi\". Eg: \"Mon:00:00-Mon:03:00\"."
  default     = null
}
variable "multi_az" {
  type        = bool
  description = "If the RDS instance is multi AZ enabled."
  default     = false
}
variable "security_group_ids" {
  type        = list(string)
  description = "List of additional security group ids to add to the RDS instance"
  default     = []
}
variable "parameter_group_parameters" {
  type        = map(string)
  description = "Map of parameters to include in the database parameter group"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "A map of AWS Tags to attach to each resource created"
  default     = {}
}
variable performance_insights {
    type = object({
      retention_period_days = number
    })
    description = "Performance Insights Configuration"
    default     = null
}