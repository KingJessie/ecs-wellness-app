variable "hosted_zone_name" {
  description = "Route53 Public hosted zone name"
  type        = string

}

variable "alb_dns_name" {
  description = "The DNS name of the ALB"
  type        = string
}

variable "alb_zone_id" {
  description = "The zone ID of the ALB"
  type        = string
}
