data "aws_subnets" "sparrow" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_lb_target_group" "sparrow" {
  name     = var.name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-302"
  }
}

resource "aws_lb_target_group_attachment" "sparrow" {
  count = length(var.instance_ids)

  target_group_arn = aws_lb_target_group.sparrow.arn
  target_id        = var.instance_ids[count.index]
  port             = 80
}

resource "aws_lb" "sparrow" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = data.aws_subnets.sparrow.ids
}

resource "aws_lb_listener" "sparrow_http" {
  count = !var.force_https ? 1 : 0

  load_balancer_arn = aws_lb.sparrow.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.sparrow.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "sparrow_http_redirect" {
  count = var.force_https ? 1 : 0

  load_balancer_arn = aws_lb.sparrow.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "sparrow_https" {
  count = var.acm_certificate_arn != null ? 1 : 0

  load_balancer_arn = aws_lb.sparrow.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.sparrow.arn
    type             = "forward"
  }
}
