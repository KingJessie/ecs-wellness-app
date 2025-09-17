data "aws_route53_zone" "primary" {
  name         = var.hosted_zone_name
  private_zone = false
}

resource "aws_route53_record" "www" {
  zone_id         = data.aws_route53_zone.primary.zone_id
  name            = "www"
  type            = "A"
  allow_overwrite = true

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}