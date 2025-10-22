resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    name    = "${var.project_name}-igw"
    project = "${var.project_name}"
  }
}