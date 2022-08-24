resource "aws_autoscaling_group" "autoscaling_group_instance" {
  
  name               = "${var.tagname}-autoscaling-group"
  desired_capacity   = 1
  max_size           = 5
  min_size           = 1

  vpc_zone_identifier = [aws_subnet.subnet_1a.id, aws_subnet.subnet_1b.id, aws_subnet.subnet_1c.id]
  target_group_arns   = [aws_lb_target_group.lb_group.id]

  launch_template {
    id      = aws_launch_template.ec2_template.id
    version = aws_launch_template.ec2_template.latest_version
  }

}
