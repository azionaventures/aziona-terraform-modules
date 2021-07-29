output "datadog_ec2_monitor_names" {
  value       = module.ec2_datadog_monitors.datadog_monitor_names
  description = "Names of the created EC2 Datadog monitors"
}

output "datadog_rds_monitor_names" {
  value       = module.rds_datadog_monitors.datadog_monitor_names
  description = "Names of the created RDS Datadog monitors"
}

output "datadog_eks_monitor_names" {
  value       = module.eks_datadog_monitors.datadog_monitor_names
  description = "Names of the created EKS Datadog monitors"
}

output "datadog_custom_monitor_names" {
  value       = module.custom_datadog_monitors.datadog_monitor_names
  description = "Names of the created custom Datadog monitors"
}

