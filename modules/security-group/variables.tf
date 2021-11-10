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
    port              = number
    my_ip             = optional(bool)
    all_traffic       = optional(bool)
    security_group_id = optional(string)
    self              = optional(bool)
    description       = optional(string)
  }))
  description = "Ingress rules for the security group"
  default     = []
}

variable "egress" {
  type = list(object({
    port              = number
    my_ip             = optional(bool)
    all_traffic       = optional(bool)
    security_group_id = optional(string)
    self              = optional(bool)
    description       = optional(string)
  }))
  description = "Egress rules for the security group"
  default     = []
}

variable "all_egress" {
  type        = bool
  description = "Whether to allow outbound traffic to the internet"
  default     = false
}
