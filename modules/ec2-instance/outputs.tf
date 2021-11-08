output "id" {
  value       = aws_instance.sparrow.id
  description = "The EC2 instance ID"
}

output "ip_address" {
  value       = aws_instance.sparrow.public_ip
  description = "The public IP address of the instance"
}
