# Application Load Balancer
resource "aws_alb" "alb" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg.id]
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]

  enable_deletion_protection = false

  tags = {
    project = "${var.project_name}"
  }
}

# ALB Target Group
resource "aws_alb_target_group" "alb-tg" {
  name        = "${var.project_name}-alb-tg"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"

  depends_on = [aws_vpc.vpc]

  #health_check {
  # enabled             = true
  # healthy_threshold   = 2
  # interval            = 30
  # matcher             = "200"
  # path                = "/"
  # port                = "traffic-port"
  # protocol            = "HTTP"
  # timeout             = 5
  # unhealthy_threshold = 2
  #}

  tags = {
    project = "${var.project_name}"
  }
}

# ALB Listener
resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    forward {
      target_group {
        arn = aws_alb_target_group.alb-tg.arn
      }
    }
  }

  tags = {
    name    = "${var.project_name}-alb-listener"
    project = "${var.project_name}"
  }
}