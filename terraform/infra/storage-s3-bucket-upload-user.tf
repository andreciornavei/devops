resource "aws_iam_user" "s3_bucket_upload_user" {
  name = "${var.tagname}-${var.uid}-s3-upload"
  tags = {
    Name         =  "s3-bucket-upload"
    Project      = "${var.projectname}"
    Environment  = "${var.environment}"
  }
}

resource "aws_iam_access_key" "s3_bucket_upload_user_access_key" {
  user = aws_iam_user.s3_bucket_upload_user.name
}

resource "aws_iam_user_policy" "s3_bucket_upload_user_policy" {
  name = "${var.tagname}-${var.uid}-policy-allow-s3"
  user = aws_iam_user.s3_bucket_upload_user.name

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "arn:aws:s3:::*"
        },
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                aws_s3_bucket.s3_bucket_upload.arn,
                "${aws_s3_bucket.s3_bucket_upload.arn}/*"
            ]
        }
    ]
  })
}

resource "aws_ssm_parameter" "ssm_appenv_storage_access_key" {
  name      = "appenv_storage_access_key"
  type      = "String"
  value     = aws_iam_access_key.s3_bucket_upload_user_access_key.id
}

resource "aws_ssm_parameter" "ssm_appenv_storage_secret_key" {
  name      = "appenv_storage_secret_key"
  type      = "String"
  value     = aws_iam_access_key.s3_bucket_upload_user_access_key.secret
}