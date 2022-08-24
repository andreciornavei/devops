resource "aws_s3_bucket" "s3_bucket_upload" {
  bucket = "${var.tagname}-${var.uid}-upload"
  tags = {
    Name         =  "s3-bucket-upload"
    Project      = "${var.projectname}"
    Environment  = "${var.environment}"
  }
}

resource "aws_s3_bucket_acl" "s3_bucket_upload_acl" {
  bucket = aws_s3_bucket.s3_bucket_upload.id
  acl    = "public-read"
}

resource "aws_ssm_parameter" "ssm_appenv_storage_provider" {
  name      = "appenv_storage_provider"
  type      = "String"
  value     = "aws-s3"
}

resource "aws_ssm_parameter" "ssm_appenv_storage_endpoint" {
  name      = "appenv_storage_endpoint"
  type      = "String"
  value     = "https://s3.${var.region}.amazonaws.com"
}

resource "aws_ssm_parameter" "ssm_appenv_storage_bucket" {
  name      = "appenv_storage_bucket"
  type      = "String"
  value     = aws_s3_bucket.s3_bucket_upload.bucket
  overwrite = true
}
resource "aws_ssm_parameter" "ssm_appenv_storage_region" {
  name      = "appenv_storage_region"
  type      = "String"
  value     = var.region
  overwrite = true
}