output "host" {
  value       = aws_db_instance.sparrow.endpoint
  description = "The host of the database instance"
}
