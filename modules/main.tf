# -----------------------
# VPC
# -----------------------
resource "aws_vpc" "aws_vpc_shimo" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true
  
  tags = {
    Name = "${var.project}-${var.enviroment}-vpc"
  }
}

# -----------------------
# subnet
# -----------------------
resource "aws_subnet" "public_subnet_1a" {
  vpc_id = aws_vpc.aws_vpc_shimo.id
  cidr_block = var.cidr_block_public_1
  availability_zone = var.az_1a

  tags = {
    Name = "${var.project}-${var.enviroment}-public-subnet-1a"
  }
}

resource "aws_subnet" "public_subnet_1c" {
  vpc_id = aws_vpc.aws_vpc_shimo.id
  cidr_block = var.cidr_block_public_2
  availability_zone = var.az_1c

  tags = {
    Name = "${var.project}-${var.enviroment}-public-subnet-1c"
  }
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id = aws_vpc.aws_vpc_shimo.id
  cidr_block = var.cidr_block_private_1
  availability_zone = var.az_1a

  tags = {
    Name = "${var.project}-${var.enviroment}-private-subnet-1a"
  }
}

# -----------------------
# Route Tables
# -----------------------
// public
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.aws_vpc_shimo.id
  tags = {
    Name = "${var.project}-${var.enviroment}-public-rtc"
  }
}

resource "aws_route_table_association" "public_rt_1a" {
  subnet_id = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_1c" {
  subnet_id = aws_subnet.public_subnet_1c.id
  route_table_id = aws_route_table.public_rt.id
}

// private
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.aws_vpc_shimo.id
  tags = {
    Name = "${var.project}-${var.enviroment}-private-rt"
  }
}

resource "aws_route_table_association" "private_rt_1a" {
  subnet_id = aws_subnet.private_subnet_1a.id
  route_table_id = aws_route_table.private_rt.id
}

# -----------------------
# Internet Gateway
# -----------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.aws_vpc_shimo.id
  tags = {
    Name = "${var.project}-${var.enviroment}-internet-gateway"
  }
}

resource "aws_route" "public_rt_igw_r" {
  route_table_id = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}