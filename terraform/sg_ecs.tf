resource "aws_security_group" "ecs-sg" {
  name        = "ecs-sg"
  description = "Allow incoming traffic to application port"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name    = "ecs-sg"
    project = "${var.project_name}"
  }
}