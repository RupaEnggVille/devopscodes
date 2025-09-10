resource "aws_vpc" "dev" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "dev-vpc"
  }
}

resource "aws_subnet" "dev-pub-1" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "dev-pub-subnet-1"
  }
}

resource "aws_subnet" "dev-pub-2" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "dev-pub-subnet-2"
  }
}

resource "aws_subnet" "dev-pub-3" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3
  tags = {
    Name = "dev-pub-subnet-3"
  }
}

resource "aws_subnet" "dev-priv-1" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = var.ZONE1
  tags = {
    Name = "dev-priv-subnet-1"
  }
}

resource "aws_subnet" "dev-priv-2" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = var.ZONE2
  tags = {
    Name = "dev-priv-subnet-2"
  }
}

resource "aws_subnet" "dev-priv-3" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = var.ZONE3
  tags = {
    Name = "dev-priv-subnet-3"
  }
}

resource "aws_internet_gateway" "dev-igw" {
  vpc_id = aws_vpc.dev.id
  tags = {
    Name = "dev-igw"
  }
}

resource "aws_route_table" "dev-public-rt" {
  vpc_id = aws_vpc.dev.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-igw.id
  }
  tags = {
    Name = "dev-public-rt"
  }
}

resource "aws_route_table_association" "dev-public-1" {
  subnet_id      = aws_subnet.dev-pub-1.id
  route_table_id = aws_route_table.dev-public-rt.id
}

resource "aws_route_table_association" "dev-public-2" {
  subnet_id      = aws_subnet.dev-pub-2.id
  route_table_id = aws_route_table.dev-public-rt.id
}

resource "aws_route_table_association" "dev-public-3" {
  subnet_id      = aws_subnet.dev-pub-3.id
  route_table_id = aws_route_table.dev-public-rt.id
}



