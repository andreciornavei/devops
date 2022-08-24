
resource "aws_lb" "lb_instance" {
  
  name               = "${var.tagname}-load-balance"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.securitygroup_computing_ec2.id]
  subnets            = [aws_subnet.subnet_1a.id, aws_subnet.subnet_1b.id, aws_subnet.subnet_1c.id]

  enable_deletion_protection = false

  tags = {
    Name        = "Load Balance"
    Project     = "${var.projectname}"
    Environment = "${var.environment}"
  }

  depends_on = [aws_internet_gateway.internet_gateway]

}