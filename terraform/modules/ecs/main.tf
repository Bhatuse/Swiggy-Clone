resource "aws_ecs_cluster" "swiggy_cluster" {
  name = "swiggy-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "swiggy_task" {
  family                   = "swiggy-task"
  requires_compatibilities = ["FARGATE"]

  network_mode = "awsvpc"

  cpu    = "256"
  memory = "512"

  execution_role_arn = var.ecs_execution_role_arn

  container_definitions = jsonencode([
    {
      name  = "swiggy-app"
      image = var.image_uri

      essential = true

      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "swiggy_service" {
  name            = "swiggy-service"
  cluster         = aws_ecs_cluster.swiggy_cluster.id
  task_definition = aws_ecs_task_definition.swiggy_task.arn

  desired_count = 2

  launch_type = "FARGATE"

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  lifecycle {
  ignore_changes = [
    task_definition,
    load_balancer
  ]
}

  network_configuration {
    subnets = var.private_subnet_ids

    security_groups = [
      var.ecs_sg_id
    ]

    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.blue_target_group_arn

    container_name = "swiggy-app"
    container_port = 80
  }
}