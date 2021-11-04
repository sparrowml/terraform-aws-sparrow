data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group" "sparrow" {
  name   = var.name
  vpc_id = var.vpc_id
  ingress = [for i in var.ingress : {
    from_port        = i.port
    to_port          = i.port
    protocol         = "tcp"
    cidr_blocks      = ["${chomp(data.http.myip.body)}/32"]
    description      = ""
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = true
  }]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
