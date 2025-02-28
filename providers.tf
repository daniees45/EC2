terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.0"
    }
  }
}

#configure the AWS Provider

provider "aws" {
    region = "us-east-1"
    shared_credentials_files = ["~/.aws/credentials"]
    profile = "cloud_user"
}