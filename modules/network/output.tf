output "vpc_id" {
  value = aws_vpc.vpc_wordpress.id
}

output "subnet_public_2a_wordpress_id" {
  value = aws_subnet.subnet_public_2a_wordpress.id
}

output "eip_bastion" {
  value = aws_eip.elastic_ip_bastion.id
}
