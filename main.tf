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
  region  = "us-east-1"
  profile = "terraform"

  default_tags {
    tags = {
      Environment = "development"
    }
  }
}

# specific resource from AWS, in thsi case is the AWS S3 Bucket
resource "aws_s3_bucket" "first-bucket-jkh35gkj235hjk2332k" {
  bucket = "my-tf-test-bucket-jkh35gkj235hjk2332k"

  tags = {
    Name      = "My first Bucket"
    ManagedBy = "Terraform"
    Owner     = "Maycon"
  }
}