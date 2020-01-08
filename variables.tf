variable "db_username" {
  type        = string
  description = "Master username for the database instance."
}

variable "db_password" {
  type        = string
  description = "Password for the master username"
}

variable "db_identifier" {
  type        = string
  description = "Name for the DB Instance"
}

variable "db_engine" {
  type        = string
  description = "The engine to be used for the database"
}

variable "db_instance_class" {
  type        = string
  description = "The instance type to use for the database"
}
