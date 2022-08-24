resource "aws_vpc" "vpc_instance" {
  cidr_block      = "10.0.0.0/16"
  tags = {
    Name         = "${var.projectname} Vpc"
    Project      = "${var.projectname}"
    Environment  = "${var.environment}"
  }
}

resource "aws_subnet" "subnet_1a" {
  vpc_id            = aws_vpc.vpc_instance.id
  availability_zone = "${var.region}a"
  cidr_block        = cidrsubnet(aws_vpc.vpc_instance.cidr_block, 4, 1)

  tags = {
    Name = "subtnet-1a"
  }

  depends_on = [aws_vpc.vpc_instance]
  
}

resource "aws_subnet" "subnet_1b" {
  vpc_id            = aws_vpc.vpc_instance.id
  availability_zone = "${var.region}b"
  cidr_block        = cidrsubnet(aws_vpc.vpc_instance.cidr_block, 4, 2)
  
  tags = {
    Name = "subtnet-1b"
  }

  depends_on = [aws_vpc.vpc_instance]

}

resource "aws_subnet" "subnet_1c" {
  vpc_id            = aws_vpc.vpc_instance.id
  availability_zone = "${var.region}c"
  cidr_block        = cidrsubnet(aws_vpc.vpc_instance.cidr_block, 4, 3)
  
  tags = {
     Name = "subtnet-1c"
  }

  depends_on = [aws_vpc.vpc_instance]

}