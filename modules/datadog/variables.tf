variable "datadog_api_key" {}
variable "datadog_app_key" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "alert_tags" {
  type = list(string)
  default = []
}

variable root_settings {
  type = object({
    enabled = number
    region = string
    name = string
    alert_tags = list(string)
    alert_tags_separator = string
    skip_region_validation = bool
  })
  default = {
    enabled = 0
    region = "eu-west-1"
    name = "datadog-terraform"
    alert_tags = []
    alert_tags_separator = "\n"
    skip_region_validation = false
  }
}

variable ec2_settings {
  type = object({
    enabled = number
    tags = map(string)
    cpu_usage_critical = number
    cpu_usage_warning = number
    cpu_usage_critical_recovery = number
    cpu_usage_warning_recovery = number
    memory_usage_critical = number
    memory_usage_warning = number
    memory_usage_critical_recovery = number
    memory_usage_warning_recovery = number
    credit_balance_critical = number
    credit_balance_warning = number
    credit_balance_critical_recovery = number
    credit_balance_warning_recovery = number
    filesystem_usage_critical = number
    filesystem_usage_warning = number
    filesystem_usage_critical_recovery = number
    filesystem_usage_warning_recovery = number
  })
  default = {
    enabled = 0
    tags = { }
    cpu_usage_critical = 0
    cpu_usage_warning = 0
    cpu_usage_critical_recovery = 0
    cpu_usage_warning_recovery = 0
    memory_usage_critical = 0
    memory_usage_warning = 0
    memory_usage_critical_recovery = 0
    memory_usage_warning_recovery = 0
    credit_balance_critical = 0
    credit_balance_warning = 0
    credit_balance_critical_recovery = 0
    credit_balance_warning_recovery = 0
    filesystem_usage_critical = 0
    filesystem_usage_warning = 0
    filesystem_usage_critical_recovery = 0
    filesystem_usage_warning_recovery = 0
  }
}

variable rds_settings {
  type = object({
    enabled = number
    cluster_identifiers = list(string)
    cpu_usage_critical = number
    cpu_usage_warning = number
    cpu_usage_critical_recovery = number
    cpu_usage_warning_recovery = number
  })
  default = {
    enabled = 0
    cluster_identifiers = []
    cpu_usage_critical = 0
    cpu_usage_warning = 0
    cpu_usage_critical_recovery = 0
    cpu_usage_warning_recovery = 0
  }
}

variable eks_settings {
  type = object({
    enabled = number
    containers = list(string)
    metrics = list(map(string))
  })
  default = {
    enabled = 0
    containers = []
    metrics = []
  }
}

variable custom_settings {
  type = object({
    enabled = number
    services = list(string)
    metrics = list(map(string))
  })
  default = {
    enabled = 0
    services = []
    metrics = []
  }
}
