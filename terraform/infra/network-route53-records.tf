resource "aws_route53_record" "route53_record" {
  for_each = {
    for dvo in aws_acm_certificate.acm_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.route53_zone.zone_id
}

resource "aws_route53_record" "alb_route53_record" {
  zone_id = aws_route53_zone.route53_zone.zone_id
  name    = "serv.${aws_route53_zone.route53_zone.name}"
  type    = "A"
  alias {
    name                   = aws_lb.lb_instance.dns_name
    zone_id                = aws_lb.lb_instance.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "mail_route53_record" {
  zone_id = aws_route53_zone.route53_zone.zone_id
  name    = "_amazonses.${aws_ses_domain_identity.ses_domain_identity.id}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.ses_domain_identity.verification_token]
}