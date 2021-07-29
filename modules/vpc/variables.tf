variable "enabled" {
  default = 0
}
variable "environment" {}
variable "vpc_cidr_block" {}
variable "aws_region" {}
variable "eks_cluster" {}

variable "shared_credentials_file" {}
variable "profile" {}