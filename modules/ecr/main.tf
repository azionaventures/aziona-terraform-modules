resource "aws_ecr_repository" "ecr-repos" {
  count = var.enabled * length(var.ecr_repositories)
  name = "${var.company}/${var.ecr_repositories[count.index]}"
}