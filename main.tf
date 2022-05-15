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

resource "aws_s3_object" "some-file" {
  bucket = aws_s3_bucket.diff-bucket-12341.bucket
  key    = "lists/${local.file_name}"
  source = local.file_name
  etag   = filemd5(local.file_name)

  tags = {
    Name = "my first s3 object"
  }
}