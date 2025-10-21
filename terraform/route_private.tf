resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway.id
  }

  tags = {
    name    = "private-route-table"
    project = "${var.project_name}"
  }
}

resource "aws_route_table_association" "private-subnet-1-rta" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "private-subnet-2-rta" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-route-table.id
}