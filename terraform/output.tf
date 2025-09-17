output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = module.ecs.cluster_name
}

output "ecs_service_name" {
  description = "ECS service name"
  value       = module.ecs.service_name
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = module.ecr.repository_url
}

output "ecs_instance_profile_name" {
  description = "ECS instance profile name"
  value       = module.iam.ecs_instance_profile_name
}

output "ecs_task_execution_role_arn" {
  description = "ECS task execution role ARN"
  value       = module.iam.ecs_task_execution_role_arn
}

output "alb_sg_id" {
  description = "ALB security group ID"
  value       = module.alb.alb_sg_id
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = module.alb.alb_dns_name
}

output "alb_arn" {
  description = "ALB ARN"
  value       = module.alb.alb_arn
}

output "alb_zone_id" {
  description = "ALB hosted zone ID"
  value       = module.alb.alb_zone_id
}

output "http_tg_arn" {
  description = "HTTP target group ARN"
  value       = module.alb.http_tg_arn
}

output "acm_certificate_arn" {
  description = "The ACM certificate ARN."
  value       = aws_acm_certificate.cert.arn
}

output "acm_certificate_validated_arn" {
  description = "The validated ACM certificate ARN."
  value       = aws_acm_certificate_validation.cert.certificate_arn
}

output "acm_certificate_domain" {
  description = "The primary domain name of the ACM certificate."
  value       = aws_acm_certificate.cert.domain_name
}

output "acm_certificate_status" {
  description = "The status of the ACM certificate."
  value       = aws_acm_certificate.cert.status
}

output "acm_certificate_validation_record_fqdns" {
  description = "The FQDNs of DNS records used for validation."
  value       = [for r in aws_route53_record.cert_validation : r.fqdn]
}

output "route53_zone_id" {
  description = "Hosted zone ID"
  value       = data.aws_route53_zone.primary.zone_id
}

output "www_record_fqdn" {
  description = "FQDN of the www record"
  value       = aws_route53_record.www.fqdn
}