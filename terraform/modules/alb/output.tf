output "alb_sg_id" {
  description = "ALB security group ID"
  value       = aws_security_group.alb_sg.id
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = aws_lb.alb.dns_name
}

output "alb_arn" {
  description = "ALB ARN"
  value       = aws_lb.alb.arn
}

output "alb_zone_id" {
  description = "ALB hosted zone ID (Route53 alias)"
  value       = aws_lb.alb.zone_id
}

output "http_tg_arn" {
  description = "HTTP target group ARN"
  value       = aws_lb_target_group.http_tg.arn
}