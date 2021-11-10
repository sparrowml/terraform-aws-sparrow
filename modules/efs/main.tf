data "aws_subnets" "sparrow" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_efs_file_system" "disk_storage" {
  creation_token = var.name

  tags = {
    Name = var.name
  }
}

resource "aws_efs_mount_target" "mounts" {
  for_each = toset(data.aws_subnets.sparrow.ids)

  file_system_id  = aws_efs_file_system.disk_storage.id
  subnet_id       = each.key
  security_groups = var.security_group_ids
}
