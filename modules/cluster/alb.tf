# =========| LOAD BALANCER |=========

resource "aws_lb" "alb" {
  name               = "alb-${var.app_name}-${var.environment}"
  load_balancer_type = var.load_balancer_type # type = ALB
  subnets            = var.public_subnets_id # out
  security_groups    = [aws_security_group.http.id]

  tags = {
    Name = "ALB for ${var.app_name}-${var.environment}"
  }
}


# =========| TARGET GROUPS |=========

resource "aws_lb_target_group" "alb" {
  name        = "tg-${var.app_name}-${var.environment}"
  port        = var.server_port
  protocol    = var.protocol_http
  vpc_id      = var.vpc_id # out
  target_type = var.target_type

  health_check {
    path                 = var.health_check_path
    protocol             = var.protocol_http
    matcher              = var.health_check_matcher
    interval             = 5
    timeout              = 3
    healthy_threshold    = 3
    unhealthy_threshold  = 2
  }

  tags = {
    Name = "Target Group for ${var.app_name}-${var.environment}"
  }
}


# =========| LISTENER |=========

resource "aws_lb_listener" "http" {
  load_balancer_arn  = aws_lb.alb.arn
  port               = var.server_port
  protocol           = var.protocol_http

  # Default return empty page with code 404
  default_action {
    type = var.listener_fixed_response.type

    fixed_response {
      content_type = var.listener_fixed_response.content_type
      message_body = var.listener_fixed_response.message_body
      status_code  = var.listener_fixed_response.status_code
    }
  }
}


# =========| LISTENER RULE |=========

resource "aws_lb_listener_rule" "http" {
  listener_arn = aws_lb_listener.http.arn
  priority     = var.listener_rule.priority

  condition {
    path_pattern {
      values = [var.listener_rule.path_pattern]
    }
  }

  action {
    type             = var.listener_rule.action_type
    target_group_arn = aws_lb_target_group.alb.arn
  }
}