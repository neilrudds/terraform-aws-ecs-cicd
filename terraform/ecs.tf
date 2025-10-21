# ECR Repository
resource "aws_ecr_repository" "ecr-repo" {
  name = var.app_name
}

# ECS Task
resource "aws_ecs_task_definition" "nodejs-backend-task" {
  family                   = "nodejs-backend-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = tostring(var.task_cpu)
  memory                   = tostring(var.task_memory)
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name  = "nodejs-app"
      image = "${aws_ecr_repository.ecr-repo.repository_url}:latest"

      portMappings = [
        {
          containerPort = var.app_port
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_logs.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
      }

      environment = [
        {
          name  = "NODE_ENV"
          value = "production"
        },
        {
          name  = "PORT"
          value = tostring(var.app_port)
        }
      ]
      essential = true
    }
  ])

  tags = {
    name    = "nodejs-backend-task"
    project = "${var.project_name}"
  }
}

# ECS Service
resource "aws_ecs_service" "ecs-service" {
  name            = "ecs-service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.nodejs-backend-task.arn
  desired_count   = var.min_capacity
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
    security_groups = [aws_security_group.alb-sg.id]
  }

  force_new_deployment = true

  placement_constraints {
    type = "distinctInstance"
  }

  triggers = {
    redeployment = timestamp()
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.alb-tg.arn
    container_name   = var.app_name
    container_port   = var.app_port
  }

  depends_on = [aws_lb_listener.alb-listener]
}

# ECS Cluster
resource "aws_ecs_cluster" "ecs-cluster" {
  name = "ecs-cluster"
}