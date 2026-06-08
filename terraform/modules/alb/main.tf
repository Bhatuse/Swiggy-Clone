resource "aws_lb" "swiggy_alb" {
  name               = "swiggy-alb"
  internal            = false
  load_balancer_type = "application"
  security_groups    = var.alb_security_groups
  subnets            = var.alb_subnets

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "alb_tg_blue" {
  name        = "alb-tg-blue"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
}

resource "aws_lb_target_group" "alb_tg_green" {
  name        = "alb-tg-green"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.swiggy_alb.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_blue.arn
  }
}