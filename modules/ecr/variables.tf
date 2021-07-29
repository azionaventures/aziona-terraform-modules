variable "enabled" {
  default = 0
}
variable "company" {}
variable "ecr_repositories" {
  type = list(string)
  default = []
}

variable "shared_credentials_file" {}
variable "profile" {}