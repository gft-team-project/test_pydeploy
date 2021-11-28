terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  
  region     = "us-east-1"
}
# create ECS cluster
resource "aws_ecs_cluster" "main" {
  name = "test-cluster"
}

#create aws task definitions

resource "aws_ecs_task_definition" "main" {
  network_mode             = "awsvpc"
  family                   = "BidnamicTest"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = "arn:aws:iam::713842441534:role/ecsrole"
  task_role_arn            = "arn:aws:iam::713842441534:role/ecsrole"
  container_definitions = jsonencode([{
    name      = "bidnamicDemo"
    image     = "713842441534.dkr.ecr.us-east-1.amazonaws.com/pyflaskrepo:latest"
    essential = true
    portMappings = [{
      protocol      = "tcp"
      containerPort = 80
      hostPort      = 80
  }] }])
}
#create aws_ecs service
resource "aws_ecs_service" "main" {
  name                = "BidnamicSampleApp"
  cluster             = aws_ecs_cluster.main.id
  task_definition     = aws_ecs_task_definition.main.arn
  desired_count       = 2
  launch_type         = "FARGATE"
  scheduling_strategy = "REPLICA"
  network_configuration {
    security_groups  = [aws_security_group.ECS-sg.id]
    subnets          = [aws_subnet.flask-subnet.id]
    assign_public_ip = true
  }
}
