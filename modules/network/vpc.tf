# Creating VPC
resource "aws_vpc" "vpc-ecommerce" {
  cidr_block           = var.vpc-cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "vpc-ecommerce"
  }
}

# Creating Public Subnets
resource "aws_subnet" "vpc-ecommerce-public1" {
  vpc_id                  = aws_vpc.vpc-ecommerce.id
  cidr_block              = var.public1-subnet-cidr_block
  map_public_ip_on_launch = "true"
  availability_zone       = var.AWS_AZ_1
  tags = {
    Name = "vpc-ecommerce-public1"
  }
}

resource "aws_subnet" "vpc-ecommerce-public2" {
  vpc_id                  = aws_vpc.vpc-ecommerce.id
  cidr_block              = var.public2-subnet-cidr_block
  map_public_ip_on_launch = "true"
  availability_zone       = var.AWS_AZ_2
  tags = {
    Name = "vpc-ecommerce-public2"
  }
}

# Creating Private Subnets
resource "aws_subnet" "vpc-ecommerce-private1" {
  vpc_id                  = aws_vpc.vpc-ecommerce.id
  cidr_block              = var.private1-subnet-cidr_block
  map_public_ip_on_launch = "false"
  availability_zone       = var.AWS_AZ_1
  tags = {
    Name = "vpc-ecommerce-private1"
  }
}

resource "aws_subnet" "vpc-ecommerce-private2" {
  vpc_id                  = aws_vpc.vpc-ecommerce.id
  cidr_block              = var.private2-subnet-cidr_block
  map_public_ip_on_launch = "false"
  availability_zone       = var.AWS_AZ_2
  tags = {
    Name = "vpc-ecommerce-private2"
  }
}

# Creating Internet Gateway
resource "aws_internet_gateway" "ecommerce-gw" {
  vpc_id = aws_vpc.vpc-ecommerce.id
  tags = {
    Name = "gateway-ecommerce"
  }
}

# Creating Routing Table
resource "aws_route_table" "ecommerce-public" {
  vpc_id = aws_vpc.vpc-ecommerce.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecommerce-gw.id
  }
  tags = {
    Name = "ecommerce-public"
  }
}

# Route Associated Public Subnets
resource "aws_route_table_association" "public-ecommerce-1" {
  subnet_id      = aws_subnet.vpc-ecommerce-public1.id
  route_table_id = aws_route_table.ecommerce-public.id
}

resource "aws_route_table_association" "public-ecommerce-2" {
  subnet_id      = aws_subnet.vpc-ecommerce-public2.id
  route_table_id = aws_route_table.ecommerce-public.id
}
