variable "name" {
  type        = string
  description = "The name of secret"
}

variable "value" {
  type        = string
  description = "The secret value"
  sensitive   = true
}
