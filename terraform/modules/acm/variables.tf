variable "domain_name" {
  description = "The domain name"
  type        = string
}

variable "hosted_zone_name" {
  description = "Route53 Public hosted zone name"
  type        = string
}

variable "tags" {
  description = "Resource tag key-value pairs"
  type        = map(string)
  default     = {}
}
