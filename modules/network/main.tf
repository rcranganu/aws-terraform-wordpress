# Create the main VPC
resource "aws_vpc" "vpc_wordpress" {
  cidr_block           = "172.16.0.0/22"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name      = "cs-vpc-${var.environment}"
    CreatedBy = "Terraform"
  }
}

# Create the IGW
resource "aws_internet_gateway" "internet_gateway_wordpress" {
  vpc_id = aws_vpc.vpc_wordpress.id
  tags = {
    Name      = "cs-igw-${var.environment}"
    CreatedBy = "Terraform"
  }
}

# Create public subnet 
resource "aws_subnet" "subnet_public_2a_wordpress" {
  availability_zone = "${var.region}a"
  vpc_id            = aws_vpc.vpc_wordpress.id
  cidr_block        = "172.16.0.0/26"
  tags = {
    Name      = "cs-subnet-${var.environment}-public-2a"
    CreatedBy = "Terraform"
  }
}

# Create private subnet 
resource "aws_subnet" "subnet_private_2a_wordpress_app" {
  availability_zone = "${var.region}a"
  vpc_id            = aws_vpc.vpc_wordpress.id
  cidr_block        = "172.16.1.0/26"
  tags = {
    Name      = "cs-subnet-${var.environment}-app-private-2a"
    CreatedBy = "Terraform"
  }
}

resource "aws_subnet" "subnet_private_2a_wordpress_data" {
  availability_zone = "${var.region}a"
  vpc_id            = aws_vpc.vpc_wordpress.id
  cidr_block        = "172.16.2.0/26"
  tags = {
    Name      = "cs-subnet-${var.environment}-data-private-2a"
    CreatedBy = "Terraform"
  }
}

# Elastic IPs
resource "aws_eip" "elastic_ip_public_2a_wordpress" {
  vpc = true
  tags = {
    Name      = "cs-eip-${var.environment}-ngw-public-2a"
    CreatedBy = "Terraform"
  }
}

resource "aws_eip" "elastic_ip_bastion" {
  vpc = true
  tags = {
    Name      = "cs-eip-${var.environment}-bastion"
    CreatedBy = "Terraform"
  }
}

# NAT Gateways
resource "aws_nat_gateway" "nat_gateway_public_2a_wordpress" {
  allocation_id = aws_eip.elastic_ip_public_2a_wordpress.id
  subnet_id     = aws_subnet.subnet_public_2a_wordpress.id
  tags = {
    Name      = "cs-ngw-${var.environment}-public-2a"
    CreatedBy = "Terraform"
  }
}

# Route Tables
resource "aws_route_table" "route_table_public_wordpress" {
  vpc_id = aws_vpc.vpc_wordpress.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway_wordpress.id
  }
  tags = {
    Name      = "cs-rt-${var.environment}-public"
    CreatedBy = "Terraform"
  }
}

resource "aws_route_table" "route_table_private_2a_wordpress_app" {
  vpc_id = aws_vpc.vpc_wordpress.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_public_2a_wordpress.id
  }
  tags = {
    Name      = "cs-rt-${var.environment}-app-private-2a"
    CreatedBy = "Terraform"
  }
}

resource "aws_route_table" "route_table_private_2a_wordpress_data" {
  vpc_id = aws_vpc.vpc_wordpress.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_public_2a_wordpress.id
  }
  tags = {
    Name      = "cs-rt-${var.environment}-data-private-2a"
    CreatedBy = "Terraform"
  }
}

# Association of Route Tables with Subnets
resource "aws_route_table_association" "route_table_association_public_2a_wordpress" {
  subnet_id      = aws_subnet.subnet_public_2a_wordpress.id
  route_table_id = aws_route_table.route_table_public_wordpress.id
}

resource "aws_route_table_association" "route_table_association_private_2a_wordpress_app" {
  subnet_id      = aws_subnet.subnet_private_2a_wordpress_app.id
  route_table_id = aws_route_table.route_table_private_2a_wordpress_app.id
}

resource "aws_route_table_association" "route_table_association_private_2a_wordpress_data" {
  subnet_id      = aws_subnet.subnet_private_2a_wordpress_data.id
  route_table_id = aws_route_table.route_table_private_2a_wordpress_data.id
}

resource "aws_main_route_table_association" "main_route_wordpress" {
  vpc_id         = aws_vpc.vpc_wordpress.id
  route_table_id = aws_route_table.route_table_public_wordpress.id
}
