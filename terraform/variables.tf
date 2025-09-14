variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "vpc_name" {
  description = "VPC name."
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

variable "availability_zones" {
  description = "AZs assigned to the VPC subnets"
  type        = list(string)
}

variable "tags" {
  description = "Resource tag key-value pairs."
  type        = map(string)
  default     = {}
}