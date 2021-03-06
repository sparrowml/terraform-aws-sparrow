
# Get the Amazon Linux 2 AMI
data "aws_ami" "sparrow" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name = "name"
    values = [
      var.ecs_cluster_name != null
      ? "amzn2-ami-ecs-hvm-*-x86_64-ebs"
      : "amzn2-ami-hvm-*-x86_64-ebs"
    ]
  }
}

data "aws_subnets" "sparrow" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "random_shuffle" "subnet" {
  input        = data.aws_subnets.sparrow.ids
  result_count = 1
}

data "template_file" "user_data" {
  template = file("${path.module}/user-data.sh")
  vars = {
    cluster_name = var.ecs_cluster_name != null ? var.ecs_cluster_name : ""
  }
}

resource "aws_instance" "sparrow" {
  ami           = var.ami != null ? var.ami : data.aws_ami.sparrow.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id != null ? var.subnet_id : random_shuffle.subnet.result[0]

  tags = {
    Name = var.name
  }

  key_name                    = var.key_name
  associate_public_ip_address = var.public
  vpc_security_group_ids      = var.security_group_ids
  iam_instance_profile        = var.iam_role
  user_data                   = var.ecs_cluster_name != null ? data.template_file.user_data.rendered : var.user_data

  root_block_device {
    volume_size = var.ecs_cluster_name != null ? max(30, var.storage) : var.storage
  }
}
