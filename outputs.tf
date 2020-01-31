output "instance" {
  value = aws_db_instance.database
}

output "security_group" {
  value = aws_security_group.db_security_group
}

output "master_username_parameter" {
  value = aws_ssm_parameter.master_username
}

output "master_password_parameter" {
  value     = aws_ssm_parameter.master_password
  sensitive = true
}
