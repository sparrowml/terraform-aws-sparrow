data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group" "sparrow" {
  name   = var.name
  vpc_id = var.vpc_id
  ingress = [for port in var.ingress_ports : {
    from_port        = port
    to_port          = port
    protocol         = "tcp"
    cidr_blocks      = var.myip ? ["${chomp(data.http.myip.body)}/32"] : []
    description      = "Opening ${port}"
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = var.self
  }]

  egress = var.egress ? [{
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Opening outbound traffic"
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = true
  }] : []
}
