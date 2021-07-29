data "aws_instances" "instances" {
  count = var.ec2_settings.enabled
  instance_tags = var.ec2_settings.tags
}

data "aws_instance" "instances" {
  count = var.ec2_settings.enabled > 0 ? length(data.aws_instances.instances.*.ids[0]) : 0
  instance_id = data.aws_instances.instances.*.ids[0][count.index]
}

# data "aws_rds_cluster" "clusters" {
#     count = length(var.rds_settings.cluster_identifiers)
#     cluster_identifier = var.rds_settings.cluster_identifiers[count.index]
# }