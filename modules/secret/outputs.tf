output "arn" {
  value = aws_secretsmanager_secret_version.secret_value.arn
}
