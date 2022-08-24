resource "aws_iam_policy_attachment" "ec2_policy_role" {
    name = "${var.tagname}-ec2-attachment"
    roles = [aws_iam_role.ec2_role.name]
    policy_arn = aws_iam_policy.ec2_policy.arn
}