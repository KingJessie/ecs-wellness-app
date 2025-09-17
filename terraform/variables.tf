variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "Project name."
  type        = string
}

variable "vpc_name" {
  description = "VPC name."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets."
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs."
  type        = list(string)

}

variable "availability_zones" {
  description = "AZs assigned to the VPC subnets"
  type        = list(string)
}

variable "tags" {
  description = "Resource tag key-value pairs."
  type        = map(string)
  default     = {}
}

variable "repository_name" {
  description = "The name of the ECR repository."
  type        = string

}

variable "cluster_name" {
  description = "The name of the ECS cluster."
  type        = string
}

variable "service_name" {
  description = "The name of the ECS service."
  type        = string
}

variable "desired_count" {
  description = "The number of instances of the task definition."
  type        = number
  default     = 1
}

variable "container_name" {
  description = "The name of the container."
  type        = string
}

variable "container_image" {
  description = "The image used to start a container."
  type        = string
}

variable "container_port" {
  description = "Container port to expose."
  type        = number
}

variable "repository_url" {
  description = "The URL of the ECR repository."
  type        = string
}


variable "domain_name" {
  description = "The domain name"
  type        = string
}

variable "hosted_zone_name" {
  description = "Route53 Public hosted zone name"
  type        = string
}

variable "image_tag" {
  description = "The Docker image tag."
  type        = string
  default     = "latest"

}