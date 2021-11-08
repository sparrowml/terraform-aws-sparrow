variable "name" {
  type        = string
  description = "The name of the instance"
}

variable "instance" {
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

variable "public" {
  type        = bool
  description = "Whether to associate a public IP address"
  default     = true
}

variable "security_group_ids" {
  type        = list(string)
  description = "The security groups to attach to the instance"
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

variable "storage" {
  type        = number
  description = "Size of the root volume in Gb"
  default     = 20
}
