terraform {
  required_version = ">= 0.12.0"
  backend "s3" {}
}

provider "datadog" {
  api_url  = "https://api.datadoghq.eu/"
  api_key  = var.datadog_api_key
  app_key  = var.datadog_app_key
  validate = false
}

provider "aws" {
  version = "~> 2.12.0"
  skip_region_validation = lookup(var.root_settings, "skip_region_validation", false)
}