# -----------------------
# TerraForm configuration
# -----------------------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {}
}

# -----------------------
# Provider
# -----------------------
provider "aws" {
  profile = "terraform-shimodaira"
  region  = var.region
}

# -----------------------
# Modules
# -----------------------
module "dev_enviroment" {
  source     = "../../modules"
  vpc_cidr_block = var.cidr_block

  project     = var.project
  enviroment = var.enviroment

  az_1a = "ap-northeast-1a"
  az_1c = "ap-northeast-1c"
  
  cidr_block_public_1 = "10.0.1.0/24"
  cidr_block_public_2 = "10.0.2.0/24"
  cidr_block_private_1 = "10.0.3.0/24"
}

