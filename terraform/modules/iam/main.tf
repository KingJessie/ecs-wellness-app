locals {
  name_prefix = var.project_name
}

# Instance profile for ECS instances
resource "aws_iam_instance_profile" "instance_profile" {
  name = "${local.name_prefix}-instance-profile"
  role = aws_iam_role.ecs_instance_role.name
  tags = var.tags
}

# EC2 hosts trust policy
data "aws_iam_policy_document" "ec2_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# IAM role for ECS instances
resource "aws_iam_role" "ecs_instance_role" {
  name               = "${local.name_prefix}-ecs-instance-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
  tags               = var.tags
}

# Allow ECS agent on EC2 hosts
resource "aws_iam_role_policy_attachment" "ecs_policy_attachment" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}


# Task execution and task roles for ECS tasks
data "aws_iam_policy_document" "ecs_task_execution_trust" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Execution role
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${local.name_prefix}-task-execution-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_trust.json
  tags               = var.tags

} 

# Attach policy to the execution role
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


