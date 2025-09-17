output "route53_zone_id" {
  description = "Hosted zone ID"
  value       = data.aws_route53_zone.primary.zone_id
}

output "www_record_fqdn" {
  description = "FQDN of the www record"
  value       = aws_route53_record.www.fqdn
}