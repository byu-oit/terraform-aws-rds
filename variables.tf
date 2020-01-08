variable "db_username" {
  type        = string
  description = "Master username for the database instance."
}

variable "db_password" {
  type        = string
  description = "Password for the master username"
}

variable "db_storage" {
  type        = number
  description = "The amount of storage to be allocated for the database"
  default     = 20
}

variable "instance_name" {
  type        = string
  description = "Name for the DB Instance"
}

variable "db_engine" {
  type        = string
  description = "The engine to be used for the database"
}

variable "db_name" {
  type        = string
  description = "The name for a database to be created in the RDS instance."
  default     = ""
}

variable "db_subnet_group" {
  type        = string
  description = "The name of the subnet group to be used for the database."
  default     = "default"
}

variable "skip_final_snapshot" {
  type        = bool
  description = "If true, skips final snapshot on destroy."
  default     = false
}

variable "final_snapshot_name" {
  type        = string
  description = "Identifier for the final snapshot created on destroy"
  default     = ""
}

variable "instance_class" {
  type        = string
  description = "The instance type to use for the database"
  default     = "db.t2.micro"
}
