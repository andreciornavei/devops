resource "aws_iam_role" "ec2_role" {
  name = "${var.tagname}-ec2-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "sts:AssumeRole",
        "Sid" : "",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        }
    }]
  })
}
