variable "region" {
  description = "Region that resources will be created in"
  type        = string
}

variable "environment" {
  description = " Env that these resources belong to"
  type        = string
}

variable "bastion_baseami" {
  description = "Custom base AMI for bastion nodes"
  type        = string
}
