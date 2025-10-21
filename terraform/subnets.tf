resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public-subnet-1_cidr
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    name    = "public-subnet-1"
    project = "${var.project_name}"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public-subnet-2_cidr
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = true

  tags = {
    name    = "public-subnet-2"
    project = "${var.project_name}"
  }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private-subnet-1_cidr
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = false

  tags = {
    name    = "private-subnet-1"
    project = "${var.project_name}"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private-subnet-2_cidr
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = false

  tags = {
    name    = "private-subnet-2"
    project = "${var.project_name}"
  }
}