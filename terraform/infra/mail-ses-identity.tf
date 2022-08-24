resource "aws_ses_domain_identity" "ses_domain_identity" {
  domain = "${var.domain}"
}