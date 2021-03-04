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
resource "aws_subnet" "subnet_private_2a_wordpress" {
  availability_zone = "${var.region}a"
  vpc_id            = aws_vpc.vpc_wordpress.id
  cidr_block        = "172.16.1.0/26"
  tags = {
    Name      = "cs-subnet-${var.environment}-private-2a"
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

