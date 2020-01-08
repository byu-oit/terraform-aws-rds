variable "rds_username" {
  type        = string
  description = "Master username for the database instance."
}

variable "rds_password" {
  type        = string
  description = "Password for the master username"
}

variable "rds_instance_name" {
  type        = string
  description = "Name for the DB Instance"
}

variable "rds_engine" {
  type        = string
  description = "The engine to be used for the database"
}

variabe "rds_db_name" {
  type        = string
  description = "The name for a database to be created in the RDS instance."
  default     = "default"
}

variable "rds_instance_class" {
  type        = string
  description = "The instance type to use for the database"
  default     = "db.t2.micro"
}
