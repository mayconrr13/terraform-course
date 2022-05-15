# https://www.terraform.io/language/values/variables
variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = "AWS profile to use terraform"
  default     = "terraform"
}