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
