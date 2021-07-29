locals {
  ec2_datadog_monitors = var.ec2_settings.enabled == 0 ? null : yamldecode(templatefile("templates/ec2-monitors.yaml", {
    instances = data.aws_instance.instances
    environment = var.root_settings.environment
    ec2_settings = var.ec2_settings
  }))

  rds_datadog_monitors = var.rds_settings.enabled == 0 ? null : yamldecode(templatefile("templates/rds-monitors.yaml", {
    # clusters = data.aws_rds_cluster.clusters
    rds_settings = var.rds_settings
    cluster_identifiers = var.rds_settings.cluster_identifiers
  }))

  eks_datadog_monitors = var.eks_settings.enabled == 0 ? null : yamldecode(templatefile("templates/eks-monitors.yaml", {
    metrics = var.eks_settings.metrics,
    environment = var.environment,
    containers = var.eks_settings.containers
  }))

  custom_datadog_monitors = var.custom_settings.enabled == 0 ? null : yamldecode(templatefile("templates/custom-monitors.yaml", {
    metrics = var.custom_settings.metrics,
    environment = var.environment,
    services = var.custom_settings.services
  }))
}

module "ec2_datadog_monitors" {
  source = "git::https://github.com/cloudposse/terraform-datadog-monitor?ref=0.17.0"

  enabled              = var.ec2_settings.enabled > 0 
  datadog_monitors     = local.ec2_datadog_monitors
  alert_tags           = length(var.alert_tags) > 0 ? var.alert_tags : var.root_settings.alert_tags
  alert_tags_separator = var.root_settings.alert_tags_separator
  datadog_synthetics   = {}

  context = module.this.context
}


module "rds_datadog_monitors" {
  source = "git::https://github.com/cloudposse/terraform-datadog-monitor?ref=0.17.0"

  enabled              = var.rds_settings.enabled > 0 
  datadog_monitors     = local.rds_datadog_monitors
  alert_tags           = length(var.alert_tags) > 0 ? var.alert_tags : var.root_settings.alert_tags
  alert_tags_separator = var.root_settings.alert_tags_separator
  datadog_synthetics   = {}

  context = module.this.context
}


module "eks_datadog_monitors" {
  source = "git::https://github.com/cloudposse/terraform-datadog-monitor?ref=0.17.0"

  enabled              = var.eks_settings.enabled > 0 
  datadog_monitors     = local.eks_datadog_monitors
  alert_tags           = length(var.alert_tags) > 0 ? var.alert_tags : var.root_settings.alert_tags
  alert_tags_separator = var.root_settings.alert_tags_separator
  datadog_synthetics   = {}

  context = module.this.context
}

module "custom_datadog_monitors" {
  source = "git::https://github.com/cloudposse/terraform-datadog-monitor?ref=0.17.0"

  enabled              = var.custom_settings.enabled > 0 
  datadog_monitors     = local.custom_datadog_monitors
  alert_tags           = length(var.alert_tags) > 0 ? var.alert_tags : var.root_settings.alert_tags
  alert_tags_separator = var.root_settings.alert_tags_separator
  datadog_synthetics   = {}

  context = module.this.context
}
