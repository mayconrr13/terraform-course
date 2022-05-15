# locking terraform and providers versions
# in this block is not possible to use vars
terraform {
  required_version = "1.1.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.14.0"
    }
  }

  # definindo um remote state na AWS com S3
  backend "s3" {
    bucket  = "tfstate-test-12309872432417"
    key     = "development/remote_state/terraform.tfstate"
    region  = "us-east-1"
    profile = "terraform"
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
    Name = "A different bucket 13"
  }
}

resource "aws_s3_bucket" "teste-20220324" {
  bucket = "teste-20220324"

  tags = {
    Description = "An old bucket manually created and added to state with terraform import"
  }
}

resource "aws_s3_bucket" "tfstate-test-12309872432417" {
  bucket = "tfstate-test-12309872432417"

  tags = {
    Name = "Remote TFSTATE Bucket"
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.tfstate-test-12309872432417.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::509741852256:user/terraform"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      aws_s3_bucket.tfstate-test-12309872432417.arn,
      "${aws_s3_bucket.tfstate-test-12309872432417.arn}/development/remote_state/terraform.tfstate",
    ]
  }
}

resource "aws_s3_bucket_versioning" "versioning_tfstate_remote" {
  bucket = aws_s3_bucket.tfstate-test-12309872432417.id
  versioning_configuration {
    status = "Enabled"
  }
}