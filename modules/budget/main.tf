locals {
  budgets = var.budgets
  cost_types = var.cost_types
}

resource "aws_budgets_budget" "budget" {
  count = local.budgets.enabled == true ? length(local.budgets.metrics) : 0

  name              = "budget-${local.budgets.metrics[count.index].name}"
  budget_type       = "${local.budgets.metrics[count.index].budget_type}"
  limit_amount      = "${local.budgets.metrics[count.index].limit_amount}"
  limit_unit        = "${local.budgets.metrics[count.index].limit_unit}"
  time_period_start = "${local.budgets.metrics[count.index].time_period_start}"
  time_unit         = "${local.budgets.metrics[count.index].time_unit}"

  cost_filters = local.budgets.metrics[count.index].cost_filters

  cost_types {
    include_credit             = local.cost_types.include_credit 
    include_discount           = local.cost_types.include_discount 
    include_other_subscription = local.cost_types.include_other_subscription 
    include_recurring          = local.cost_types.include_recurring 
    include_refund             = local.cost_types.include_refund 
    include_subscription       = local.cost_types.include_subscription 
    include_support            = local.cost_types.include_support 
    include_tax                = local.cost_types.include_tax 
    include_upfront            = local.cost_types.include_upfront 
    use_blended                = local.cost_types.use_blended 
  }

  dynamic "notification" {
    for_each = local.budgets.metrics[count.index].notifications

    content {
      comparison_operator = notification.value.comparison_operator
      threshold           = notification.value.threshold
      threshold_type      = notification.value.threshold_type
      notification_type   = notification.value.notification_type
      subscriber_email_addresses = notification.value.subscriber_email_addresses
    }
  }
}