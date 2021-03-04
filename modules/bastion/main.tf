# Create bastion instance
resource "aws_instance" "bastion_instance" {
  availability_zone      = "${var.region}a"
  ami                    = var.bastion_baseami
  instance_type          = "t2.micro"
  subnet_id              = var.instance_subnet_id
  vpc_security_group_ids = var.instance_security_group_ids
  key_name               = "cs-key-${var.environment}"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "20"
    delete_on_termination = true
  }

  tags = {
    Name      = "cs-ec2-${var.environment}-bastion"
    CreatedBy = "Terraform"
  }
}

resource "aws_eip_association" "bastion_eip_assoc" {
  instance_id   = aws_instance.bastion_instance.id
  allocation_id = var.eip_bastion
}
