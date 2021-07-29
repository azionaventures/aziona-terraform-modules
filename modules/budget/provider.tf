terraform {
  required_version = ">= 0.12.0"
  backend "s3" {}
}

provider "aws" {
  version = "~> 2.31.0"
}