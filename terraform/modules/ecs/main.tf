locals {
  name_prefix = var.project_name
}

# ECS cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${local.name_prefix}-ecs-cluster"
  tags = var.tags
}

# Task definition
resource "aws_ecs_task_definition" "service" {
  family                   = "service"
  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"
  execution_role_arn       = var.ecs_task_execution_role_arn

  container_definitions = jsonencode([
    {
      name                   = "${local.name_prefix}-app"
      image                  = "${var.repository_url}:${var.image_tag}"
      cpu                    = 128
      memory                 = 512
      essential              = true
      readonlyRootFilesystem = true

      portMappings = [
        { containerPort = 3031, protocol = "tcp" }
      ]

      environment = [
        { name = "DD_UWSGI_MODE", value = "http-socket" },
        { name = "DD_UWSGI_ENDPOINT", value = "0.0.0.0:3031" }
      ]
    }
  ])

  tags = merge(var.tags, { Name = "service-task-definition" })
}


# Security group for task
resource "aws_security_group" "ecs_task_sg" {
  name        = "${local.name_prefix}-ecs-task-sg"
  description = "Allow inbound traffic from ALB to ECS tasks"
  vpc_id      = var.vpc_id
  tags        = merge(var.tags, { Name = "ecs-task-sg" })

  ingress {
    from_port       = 3031
    to_port         = 3031
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
    description     = "ALB to tasks HTTP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All egress"
  }
}

# ECS service
resource "aws_ecs_service" "ecs_service" {
  name            = "${local.name_prefix}-ecs-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.service.arn
  launch_type     = "EC2"
  desired_count   = 3

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = var.http_tg_arn
    container_name   = "${local.name_prefix}-app"
    container_port   = 3031
  }

  network_configuration {
    subnets         = var.public_subnet_ids
    security_groups = [aws_security_group.ecs_task_sg.id]
  }

  tags = merge(var.tags, { Name = "ecs-service" })
}

# ECS instances security group
resource "aws_security_group" "ecs_instance_sg" {
  name        = "${local.name_prefix}-instance-sg"
  description = "ECS container instances"
  vpc_id      = var.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound"
  }

  tags = merge(var.tags, { Name = "ecs-instance-sg" })
}

data "aws_ssm_parameter" "ecs_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

# Launch template
resource "aws_launch_template" "ec2_launch_template" {
  name_prefix   = "${local.name_prefix}-template"
  image_id      = data.aws_ssm_parameter.ecs_ami.value
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.ecs_instance_sg.id]
  iam_instance_profile {
    name = var.ecs_instance_profile_name
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 30
      volume_type = "gp2"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ecs-instance"
    }
  }

  user_data = base64encode(<<EOF
#!/bin/bash
echo "ECS_CLUSTER=${local.name_prefix}-ecs-cluster" >> /etc/ecs/ecs.config
EOF
  )
}

# Auto Scaling Group
resource "aws_autoscaling_group" "asg" {
  name                      = "${local.name_prefix}-asg"
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 3
  vpc_zone_identifier       = var.public_subnet_ids
  health_check_type         = "EC2"
  health_check_grace_period = 300
  force_delete              = true

  launch_template {
    id      = aws_launch_template.ec2_launch_template.id
    version = "$Latest"
  }


  tag {
    key                 = "Name"
    value               = "${local.name_prefix}-ecs-instance"
    propagate_at_launch = true
  }

}
