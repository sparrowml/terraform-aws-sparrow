variable "name" {
  type        = string
  description = "The name of the security group"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC to put the security group in"
}

variable "ingress" {
  type = list(object({
    port = number
  }))
  description = "Simplified options for each ingress entry"
}
