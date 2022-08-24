resource "aws_s3_bucket" "s3_bucket_app" {
  bucket = "${var.tagname}-${var.uid}-deploy"
  tags = {
    Name         =  "s3-bucket-app-deploy"
    Project      = "${var.projectname}"
    Environment  = "${var.environment}"
  }
}

resource "aws_ssm_parameter" "ssm_bucket_server_deploy" {
  name      = "bucket_server_deploy"
  type      = "String"
  value     = aws_s3_bucket.s3_bucket_app.bucket
}