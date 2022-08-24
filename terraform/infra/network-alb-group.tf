resource "aws_lb_target_group" "lb_group" {
  
  name          = "${var.tagname}-lb-group"
  target_type   = "instance"
  port          = 80
  protocol      = "HTTP"
  vpc_id        = aws_vpc.vpc_instance.id

  tags = {
    Name        = "application-load-balancer"
    Project     = "${var.projectname}"
    Environment = "${var.environment}"
  }

}