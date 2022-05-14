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
    tags = {
      ManagedBy   = "Terraform: ${var.aws_profile}"
      Owner       = "Maycon"
      Environment = "development"
    }
  }
}

resource "aws_instance" "first-ec2" {
  ami           = "ami-09d56f8956ab235b3"
  instance_type = "t2.micro"

  tags = {
    Name = "My first EC2 Instance"
  }
}