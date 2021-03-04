# Create the network
module "network" {
  source      = "../modules/network"
  region      = var.region
  environment = var.environment
}

# Create the s3 buckets
module "s3_bucket" {
  source      = "../modules/s3_bucket"
  environment = var.environment
}



