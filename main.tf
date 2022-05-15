# locking terraform and providers versions
terraform {
  required_version = "1.1.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.14.0"
    }
  }
}

# AWS provider configuration
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = local.common_tags
  }
}

resource "aws_s3_bucket" "diff-bucket-12341" {
  bucket = "diff-12341"

  tags = {
    Name = "A different bucket"
  }
}

resource "aws_s3_bucket" "teste-20220324" {
  bucket = "teste-20220324"

  tags = {
    Description = "An old bucket manually created and added to state with terraform import"
  }
}