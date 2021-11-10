terraform {
  experiments = [module_variable_optional_attrs]
}

data "http" "my_ip" {
  url = "http://ipv4.icanhazip.com"
}

locals {
  ingress = [for i in var.ingress : defaults(i, {
    description = ""
    my_ip       = false
    all_traffic = false
    self        = false
  })]
  egress = [for e in var.egress : defaults(e, {
    description = ""
    my_ip       = false
    all_traffic = false
    self        = false
  })]
}

resource "aws_security_group" "sparrow" {
  name   = var.name
  vpc_id = var.vpc_id

  ingress = [for i in local.ingress : {
    description      = i.description
    from_port        = i.port
    to_port          = i.port
    protocol         = "tcp"
    self             = i.self
    security_groups  = i.security_group_id != null ? [i.security_group_id] : []
    ipv6_cidr_blocks = []
    prefix_list_ids  = []

    cidr_blocks = concat(
      i.my_ip ? ["${chomp(data.http.my_ip.body)}/32"] : [],
      i.all_traffic ? ["0.0.0.0/0"] : []
    )
  }]

  egress = var.all_egress ? [{
    description      = "Opening outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    self             = false
    security_groups  = []
    ipv6_cidr_blocks = []
    prefix_list_ids  = []

    cidr_blocks = ["0.0.0.0/0"]
    }] : [for e in local.egress : {
    description      = e.description
    from_port        = e.port
    to_port          = e.port
    protocol         = "tcp"
    self             = e.self
    security_groups  = e.security_group_id != null ? [e.security_group_id] : []
    ipv6_cidr_blocks = []
    prefix_list_ids  = []

    cidr_blocks = concat(
      e.my_ip ? ["${chomp(data.http.my_ip.body)}/32"] : [],
      e.all_traffic ? ["0.0.0.0/0"] : []
    )
  }]
}
