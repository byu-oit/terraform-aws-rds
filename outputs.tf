output "rds_database" {
  value = aws_db_instance.database.endpoint
}
