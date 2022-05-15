locals {
  file_name = "db.json"
  common_tags = {
    ManagedBy   = "Terraform: ${var.aws_profile}"
    Owner       = "Maycon"
    Environment = "development"
  }
}