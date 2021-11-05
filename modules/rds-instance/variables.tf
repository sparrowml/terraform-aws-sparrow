variable "name" {
  type        = string
  description = "The name of the instance and database"
}

variable "engine" {
  type        = string
  default     = "postgres"
  description = <<EOT
    Type of database. Can be one of 'postgres', 'mysql', 'aurora', 'aurora-postgresql', ...
    See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/rds_engine_version#engine
    for a list of available engines.
  EOT
}

variable "engine_version" {
  type        = string
  default     = null
  description = "The database engine version to use"
}

variable "instance" {
  type        = string
  description = "The type of the instance"
}

variable "storage" {
  type        = number
  description = "Size of the storage volume in Gb"
  default     = 20
}

variable "encrypt" {
  type        = bool
  description = "Whether to encrypt the storage on disk"
  default     = true
}

variable "public" {
  type        = bool
  description = "Whether to make the database publicly accessible"
  default     = true
}

variable "security_group_id" {
  type        = string
  description = "The security group to attach to the instance"
  default     = null
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC to put the instance in"
}

variable "auth" {
  type = object({
    username = string
    password = string
  })
  sensitive   = true
  description = "Username and password for the database"
}
