resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc_instance.id

  tags = {
    Name = "${var.projectname} Internet Gateway"
    Project = "${var.projectname}"
    Environment = "${var.environment}"
  }
}