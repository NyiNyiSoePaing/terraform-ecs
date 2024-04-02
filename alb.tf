# alb.tf

resource "aws_alb" "main" {
  name            = "${replace(var.env, "_", "-")}-ECS-alb" # To convert underscores in the ${var.env} variable to hyphens
  subnets         = [aws_subnet.public_1a.id, aws_subnet.public_1b.id]
  security_groups = [aws_security_group.alb.id]
}

resource "aws_lb_target_group" "app" {
  name        = "${replace(var.env, "_", "-")}-demo-app-tg" # To convert underscores in the ${var.env} variable to hyphens
  vpc_id      = aws_vpc.main.id
  protocol    = "HTTP"
  port        = 80
  target_type = "ip"

  health_check {
    enabled             = true
    path                = "/"
    port                = 80
    matcher             = 200
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_alb.main.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.id
  }
}

