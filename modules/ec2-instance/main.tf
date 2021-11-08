
# Get the Amazon Linux 2 AMI
data "aws_ami" "sparrow" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

resource "aws_instance" "sparrow" {
  ami           = data.aws_ami.sparrow.id
  instance_type = var.instance

  tags = {
    Name = var.name
  }

  key_name                    = var.key_name
  associate_public_ip_address = var.public
  vpc_security_group_ids      = var.security_group_ids
  iam_instance_profile        = var.iam_role
  user_data                   = var.user_data

  root_block_device {
    volume_size = var.storage
  }
}
