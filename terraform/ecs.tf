resource "aws_ecs_cluster" "main" {
  name = local.name

  tags = local.tags
}

resource "aws_ecs_service" "main" {
  name            = local.name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = 1

  network_configuration {
    subnets          = [for x in keys(aws_subnet.public) : aws_subnet.public[x].id]
    security_groups  = [aws_security_group.main.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.main.arn
    container_name   = local.name
    container_port   = 5000
  }

  tags = local.tags
}

resource "aws_ecs_task_definition" "main" {
  family = local.name
  container_definitions = jsonencode([
    {
      name      = local.name
      image     = "masasuzu/ex-return-403-app:latest"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
        }
      ]
    }
  ])
}