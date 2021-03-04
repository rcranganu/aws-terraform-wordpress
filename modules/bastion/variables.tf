variable "region" {
  description = "Region in which this instance will be created"
  type        = string
}

variable "environment" {
  description = "Which environment will use this instance"
  type        = string
}

variable "bastion_baseami" {
  description = "AMI image for bastion"
  type        = string
}

variable "instance_subnet_id" {
  description = "ID of the subnet to create this instance in"
  type        = string
}

variable "instance_security_group_ids" {
  description = "List of security group IDs to associate with this instance"
  type        = list(any)
}

variable "eip_bastion" {
  description = "ID of EIP to associate with instance"
  type        = string
}
