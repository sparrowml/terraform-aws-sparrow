variable "name" {
  type        = string
  description = "The name of the instance"
}

variable "instance_type" {
  type        = string
  description = "The type of the instance"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC to put the instance in"
}

variable "key_name" {
  type        = string
  description = "The name of the key pair for SSH access"
}

variable "public_ip" {
  type        = bool
  description = "Whether to associate a public IP address"
  default     = true
}

variable "security_group_id" {
  type        = string
  description = "The security group to attach to the instance"
  default     = null
}

variable "iam_role" {
  type        = string
  description = "The name of the IAM role to attach to the instance"
  default     = null
}

variable "user_data" {
  type        = string
  description = "A script to run on instance launch"
  default     = null
}

variable "volume_size" {
  type        = number
  description = "Size of the root volume in Gb"
  default     = 20
}
