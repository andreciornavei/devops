resource "aws_iam_user" "ses_mail_user" {
  name = "${var.tagname}-${var.uid}-ses-mail-user"
  tags = {
    Name         =  "ses-mail-user"
    Project      = "${var.projectname}"
    Environment  = "${var.environment}"
  }
}

resource "aws_iam_access_key" "ses_mail_user_access_key" {
  user = aws_iam_user.ses_mail_user.name
}

resource "aws_iam_user_policy" "ses_mail_user_policy" {
  name = "${var.tagname}-${var.uid}-policy-allow-ses"
  user = aws_iam_user.ses_mail_user.name
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Action": "ses:SendRawEmail",
        "Resource": "*"
    }]
  })
}

resource "aws_ssm_parameter" "ssm_appenv_ses_access_key" {
  name      = "appenv_ses_access_key"
  type      = "String"
  value     = aws_iam_access_key.ses_mail_user_access_key.id
}

resource "aws_ssm_parameter" "ssm_appenv_ses_secret_key" {
  name      = "appenv_ses_secret_key"
  type      = "String"
  value     = aws_iam_access_key.ses_mail_user_access_key.secret
}

resource "aws_ssm_parameter" "ssm_appenv_ses_provider" {
  name      = "appenv_ses_provider"
  type      = "String"
  value     = "aws-ses-service"
}