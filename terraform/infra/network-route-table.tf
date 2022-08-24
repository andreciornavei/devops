resource "aws_route_table" "alb_routing_table" {
  vpc_id = aws_vpc.vpc_instance.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.projectname} Router Table"
    Project = "${var.projectname}"
    Environment = "${var.environment}"
  }
}


resource "aws_route_table_association" "rpute_table_assoc_subnet_1a" {
  subnet_id      = aws_subnet.subnet_1a.id
  route_table_id = aws_route_table.alb_routing_table.id
}

resource "aws_route_table_association" "rpute_table_assoc_subnet_1b" {
  subnet_id      = aws_subnet.subnet_1b.id
  route_table_id = aws_route_table.alb_routing_table.id
}

resource "aws_route_table_association" "rpute_table_assoc_subnet_1v" {
  subnet_id      = aws_subnet.subnet_1c.id
  route_table_id = aws_route_table.alb_routing_table.id
}