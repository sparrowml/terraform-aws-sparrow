output "dns" {
  value       = aws_lb.sparrow.dns_name
  description = "The DNS of the database instance"
}
