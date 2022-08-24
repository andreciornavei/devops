resource "aws_ecr_repository" "ecr_repository" {
  name                 = "server-${var.tagname}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ssm_parameter" "ssm_ecr_repository_url" {
  name      = "ecr_repository_url"
  type      = "String"
  value     = aws_ecr_repository.ecr_repository.repository_url
  overwrite = true
}