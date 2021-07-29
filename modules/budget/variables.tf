variable "budgets" {
  type = object({
    enabled = bool
    metrics = list(
      object({
        name              = string
        budget_type       = string
        cost_filters      = map(string)
        limit_amount      = string
        limit_unit      = string
        time_period_start = string
        time_unit         = string
        notifications      = list(object({
          comparison_operator        = string
          threshold                  = number
          threshold_type             = string
          notification_type          = string
          subscriber_email_addresses = list(string)
        })) 
      })
    )
  })
  default = {
    enabled = false
    metrics = []
  }
}

variable "cost_types" {
  type = object({
    include_credit             = bool
    include_discount           = bool
    include_other_subscription = bool
    include_recurring          = bool
    include_refund             = bool
    include_subscription       = bool
    include_support            = bool
    include_tax                = bool
    include_upfront            = bool
    use_blended                = bool
  })
  default = {
    include_credit             = false
    use_blended                = false
    include_refund             = false
    include_discount           = true
    include_other_subscription = true
    include_recurring          = true
    include_subscription       = true
    include_support            = true
    include_tax                = true
    include_upfront            = true
  }
}