data "http" "my_ip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group" "sparrow" {
  name   = var.name
  vpc_id = var.vpc_id
  ingress = [for port in var.ingress_ports : {
    from_port = port
    to_port   = port
    protocol  = "tcp"

    cidr_blocks = concat(
      var.my_ip ? ["${chomp(data.http.my_ip.body)}/32"] : [],
      var.all_traffic ? ["0.0.0.0/0"] : []
    )

    description      = "Opening ${port}"
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = var.security_group_ids
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
