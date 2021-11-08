variable "name" {
  type        = string
  description = "The name of ALB"
}

variable "security_group_ids" {
  type        = list(string)
  description = "The security groups to attach to the ALB"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC to put the ALB in"
}

variable "instance_ids" {
  type        = list(string)
  description = "A list of EC2 instance IDs to point the ALB to"
}

variable "acm_certificate_arn" {
  type        = string
  description = "An ACM certificate that's already been issued"
  default     = null
}

variable "force_https" {
  type        = bool
  description = "Whether to redirect traffic to HTTPS"
  default     = true
}
