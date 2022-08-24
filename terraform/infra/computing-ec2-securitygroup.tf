resource "aws_security_group" "securitygroup_computing_ec2" {

  name        = "${var.tagname}-computing-sg-traffic"
  description = "Allow Inbound and Outbound computing traffic"
  vpc_id      = aws_vpc.vpc_instance.id
  
  ingress {
    description = "Any http traffic inbound"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Any https traffic inbound"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Any traffic outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "ec2-security-group-traffic"
    Project     = "${var.projectname}"
    Environment = "${var.environment}"
  }

}
