resource "aws_security_group" "bastion_security_group" {
  name        = "cs-sg-${var.wordpress_environment_id}-bastion"
  description = "Security group for the Bastion instance on ${var.wordpress_environment_id}"
  vpc_id      = var.wordpress_vpc_id

  ingress {
    description = "SSH access to bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cs-sg-${var.wordpress_environment_id}-bastion"
  }
}
