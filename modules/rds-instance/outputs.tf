output "host" {
  value       = split(":", aws_db_instance.sparrow.endpoint)[0]
  description = "The host of the database instance"
}
