terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "aws-tf-backend-state"
    key            = "state/terraform-prod.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "terraform-state"
  }
}

provider "aws" {
  region = "eu-central-1"
}