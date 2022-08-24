resource "aws_iam_instance_profile" "ec2_profile" {
    name = "${var.tagname}-ec2-profile"
    role = aws_iam_role.ec2_role.name
}
