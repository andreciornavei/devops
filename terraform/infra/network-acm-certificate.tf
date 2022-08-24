resource "aws_acm_certificate" "acm_certificate" {
  domain_name       = "${var.domain}"
  subject_alternative_names = ["serv.${var.domain}"]
  validation_method = "DNS"

  tags = {
    Name        = "acm-certificate"
    Project     = "${var.projectname}"
    Environment = "${var.environment}"
  }

  lifecycle {
    create_before_destroy = true
  }
}