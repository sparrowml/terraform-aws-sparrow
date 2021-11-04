output "ip_address" {
  value       = aws_instance.sparrow.public_ip
  description = "The public IP address of the instance"
}
