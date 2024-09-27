# versions.tf

# Terraform Settings Block

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.17.0"
    }
  }
  required_version = ">= 0.15"
} 

# Provider Block

provider "aws" {
  alias  = "dev"
  #region = var.env[dev].region
  region =  us-east-2
}

provider "aws" {
  alias  = "test"
  #region = var.env[dev].region
  region = us-east-1
}

/*
provider "aws" {
  region = var.region
  #assume_role {
  #  role_arn = var.cross_account_role_arn
  #}  
}
*/
