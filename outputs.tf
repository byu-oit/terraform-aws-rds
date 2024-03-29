output "instance" {
  value     = aws_db_instance.database
  sensitive = true
}

output "security_group" {
  value = aws_security_group.db_security_group
}

output "master_username_parameter" {
  value     = aws_ssm_parameter.master_username
  sensitive = true
}

output "master_password_parameter" {
  value     = aws_ssm_parameter.master_password
  sensitive = true
}

output "parameter_group" {
  value = aws_db_parameter_group.parameter_group
}