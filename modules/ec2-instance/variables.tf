variable "name" {
  type        = string
  description = "The name of the instance"
}

variable "instance_type" {
  type        = string
  description = "The type of the instance"
}

variable "ami" {
  type        = string
  description = "Which AMI to use for the instance"
  default     = null
}

variable "subnet_id" {
  type        = string
  description = "Which subnet to use for the instance"
  default     = null
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC to put the instance in"
}

variable "key_name" {
  type        = string
  description = "The name of the key pair for SSH access"
  default     = null
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

variable "ecs_cluster_name" {
  type        = string
  description = "The name of the ECS cluster to join"
  default     = null
}
