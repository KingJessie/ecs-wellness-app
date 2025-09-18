variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "Project name."
  type        = string
  default     = "ddojo"
}

variable "vpc_name" {
  description = "VPC name."
  type        = string
  default     = "main-vpc"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.1.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets."
  type        = list(string)
  default     = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "availability_zones" {
  description = "AZs assigned to the VPC subnets"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b"]
}

variable "tags" {
  description = "Resource tag key-value pairs."
  type        = map(string)
  default = {
    "Environment" = "dev"
  "Owner" = "jessie.king" }

}

variable "domain_name" {
  description = "The domain name"
  type        = string
  default     = "jessking-lab.com"
}

variable "hosted_zone_name" {
  description = "Route53 Public hosted zone name"
  type        = string
  default     = "jessking-lab.com"
}

variable "image_tag" {
  description = "The Docker image tag."
  type        = string
  default     = "latest"

}