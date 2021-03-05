# Create the network
module "network" {
  source      = "../../modules/network"
  region      = var.region
  environment = var.environment
}

module "security" {
  source                   = "../../modules/security"
  wordpress_vpc_id         = module.network.vpc_id
  wordpress_environment_id = var.environment
}

# Create the s3 buckets
module "s3_bucket" {
  source      = "../../modules/s3_bucket"
  environment = var.environment
}

# Create the Bastion instance
module "bastion" {
  source             = "../../modules/bastion"
  region             = var.region
  environment        = var.environment
  bastion_baseami    = var.bastion_baseami
  instance_subnet_id = module.network.subnet_public_2a_wordpress_id
  instance_security_group_ids = [
    module.security.sg_bastion_id
  ]
  eip_bastion = module.network.eip_bastion
}



