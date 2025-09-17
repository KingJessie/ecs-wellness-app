variable "tags" {
  description = "Resource tag key-value pairs."
  type        = map(string)
  default = {
    Environment = "dev"
  }
}

variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "repository_url" {
  description = "The URL of the ECR repository."
  type        = string
}

variable "image_tag" {
  description = "The Docker image tag."
  type        = string
  default     = "latest"
}

variable "ecs_instance_profile_name" {
  description = "The name of the ECS instance profile."
  type        = string
}

variable "ecs_task_execution_role_arn" {
  description = "The ARN of the ECS task execution role."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs."
  type        = list(string)
}

variable "availability_zones" {
  description = "AZs assigned to the VPC subnets"
  type        = list(string)
}

variable "alb_sg_id" {
  description = "The security group ID for the ALB."
  type        = string
}

variable "http_tg_arn" {
  description = "The ARN of the HTTP target group."
  type        = string
}