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