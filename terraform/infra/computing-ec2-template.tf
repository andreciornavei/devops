data "aws_caller_identity" "current" {}

resource "aws_launch_template" "ec2_template" {

  name          = "${var.tagname}-autoscaling-application"
  image_id      = data.aws_ami.ami_instance.id
  instance_type = var.ec2_instance_class
  ebs_optimized = false

  user_data = base64encode(templatefile("${path.module}/computing-ec2-template-userdata.tftpl", {
    aws_region     = var.region,
    aws_account_id = data.aws_caller_identity.current.account_id,
    app_tagname    = var.tagname
  }))

  # #key to access ssh (should create a ssh key pair on console first named ssh_ec2)
  key_name = "ssh_ec2"

  iam_instance_profile {
    arn = aws_iam_instance_profile.ec2_profile.arn
  }

  network_interfaces {
    device_index                = 0
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = [aws_security_group.securitygroup_computing_ec2.id]
  }

  tags = {
    Name        = "aws-launch-template"
    Project     = "${var.projectname}"
    Environment = "${var.environment}"
  }

}
