variable "username" {
  type        = string
  description = "Master username for the database instance."
}

variable "password" {
  type        = string
  description = "Password for the master username"
}

variable "instance_name" {
  type        = string
  description = "Name for the DB Instance"
}

variable "db_engine" {
  type        = string
  description = "The engine to be used for the database"
}

variable "instance_type" {
  type        = string
  description = "The instance type to use for the database"
}
