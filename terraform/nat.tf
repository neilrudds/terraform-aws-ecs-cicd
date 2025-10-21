# Elastic IP
resource "aws_eip" "eip-nat" {

  tags = {
    name    = "eip-nat"
    project = "${var.project_name}"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.eip-nat.id
  subnet_id     = aws_subnet.public-subnet-2.id

  tags = {
    name    = "nat-gateway"
    project = "${var.project_name}"
  }
}