terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket         = "aws-tf-state-sandbox"
    key            = "tf-state-sandbox"
    region         = "eu-west-2"
    encrypt        = true
    dynamodb_table = "aws-tf-state-sandbox"
  }
}
