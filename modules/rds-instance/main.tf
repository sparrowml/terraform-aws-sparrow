data "aws_subnets" "sparrow" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_db_subnet_group" "sparrow" {
  name       = var.name
  subnet_ids = data.aws_subnets.sparrow.ids
}

resource "aws_db_instance" "sparrow" {
  identifier              = var.name
  engine                  = var.engine
  engine_version          = var.engine_version
  apply_immediately       = var.apply_immediately
  backup_retention_period = var.backup_retention_period

  instance_class    = var.instance_type
  allocated_storage = var.storage
  storage_encrypted = var.encrypt

  name     = var.name
  username = var.auth.username
  password = var.auth.password

  db_subnet_group_name = aws_db_subnet_group.sparrow.name
  publicly_accessible  = var.public
  skip_final_snapshot  = true

  vpc_security_group_ids = var.security_group_ids
}
