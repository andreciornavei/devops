resource "aws_security_group" "securitygroup_database_rds" {
  
  name        = "${var.tagname}-database-sg-traffic"
  description = "Allow Inbound and Outbound traffic for database connections"
  vpc_id      = aws_vpc.vpc_instance.id
  
  ingress {
    description = "Tcp traffic for database connections"
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "database-security-group-traffic"
    Project     = "${var.projectname}"
    Environment = "${var.environment}"
  }

}