variable "arn_iam_users" { 
  type = list(string)
  default = [ ]
}
variable "s3_buckets" {
  type = list(string)
  default = [
     "arn:aws:s3:::*"
  ]
}
variable "environment" {}
variable "organization_name" {}
variable "eks_region" {}
variable "ecr_region" {}

variable "shared_credentials_file" {}
variable "profile" {}