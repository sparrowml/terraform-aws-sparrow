variable "name" {
  type        = string
  description = "The name of file system"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC to put the file system in"
}

variable "security_group_ids" {
  type        = list(string)
  description = "The security groups to attach to the file system"
}
