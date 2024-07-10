resource "google_billing_budget" "trial" {
  billing_account = data.google_billing_account.main.id
  display_name    = "Trial $300 circuit breaker"

  amount {
    specified_amount {
      currency_code = "USD"
      units         = 300
    }
  }

  dynamic "threshold_rules" {
    for_each = local.thresholds
    content {
      threshold_percent = threshold_rules.value
    }
  }

  # Additional rule for forecasted spend at 100%
  threshold_rules {
    threshold_percent = 1.0
    spend_basis       = "FORECASTED_SPEND"
  }

  all_updates_rule {
    pubsub_topic   = data.terraform_remote_state.pubsub.outputs.budget_topic_id
    schema_version = "1.0"
  }

  # The absence of budget_filter block means the budget applies to all services in all projects
}
