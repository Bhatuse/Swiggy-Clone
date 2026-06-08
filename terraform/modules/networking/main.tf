resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name        = "main"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "swiggy_ig" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "swiggy-ig"
    Environment = var.environment
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_1_cidr
  availability_zone = var.availability_zones[0]

  tags = {
    Name        = "private_subnet_1"
    Environment = var.environment
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_2_cidr
  availability_zone = var.availability_zones[1]

  tags = {
    Name        = "private_subnet_2"
    Environment = var.environment
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_1_cidr
  availability_zone = var.availability_zones[0]

  tags = {
    Name        = "public_subnet_1"
    Environment = var.environment
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_2_cidr
  availability_zone = var.availability_zones[1]

  tags = {
    Name        = "public_subnet_2"
    Environment = var.environment
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.swiggy_ig.id
  }

  tags = {
    Name        = "public_rt"
    Environment = var.environment
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

 route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.swiggy_nat.id
  }

  tags = {
    Name        = "private_rt"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "public_subnet_1_assoc" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_subnet_2_assoc" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_subnet_1_assoc" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_subnet_2_assoc" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_eip" "swiggy_eip" {
  domain   = "vpc"

  tags = {
    Name        = "swiggy-eip"
    Environment = var.environment
  }
}

resource "aws_nat_gateway" "swiggy_nat" {
  allocation_id = aws_eip.swiggy_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name        = "swiggy_nat"
    Environment = var.environment
  }

  depends_on = [aws_internet_gateway.swiggy_ig]
}