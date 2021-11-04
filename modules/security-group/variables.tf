variable "name" {
  type        = string
  description = "The name of the security group"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC to put the security group in"
}

variable "ingress_ports" {
  type        = list(number)
  description = "Ports to open for TCP traffic"
}

variable "myip" {
  type        = bool
  description = "Whether to whitelist the developer's IP address"
  default     = false
}

variable "self" {
  type        = bool
  description = "Whether to whitelist other instances with the same security group"
  default     = true
}

variable "egress" {
  type        = bool
  description = "Whether to allow outbound traffic to the internet"
  default     = true
}
