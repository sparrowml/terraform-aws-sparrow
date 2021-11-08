output "dns" {
  value       = split(":", aws_db_instance.sparrow.endpoint)[0]
  description = "The DNS of the database instance"
}
