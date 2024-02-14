resource "aws_vpc" "demo_vpc" {
  tags = {
    Name = var.vpc_name
  }
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "demo_subnet1" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "${var.vpc_name}-subnet1"
  }
  availability_zone       = data.aws_availability_zones.available.names[0]
  cidr_block              = var.subnet_cidr[0]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "demo_subnet2" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "${var.vpc_name}-subnet2"
  }
  availability_zone       = data.aws_availability_zones.available.names[1]
  cidr_block              = var.subnet_cidr[1]
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_default_route_table" "demo_vpc_default_rt" {
  tags = {
    Name = "${var.vpc_name}-default-rt"
  }
  default_route_table_id = aws_vpc.demo_vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_igw.id
  }
}