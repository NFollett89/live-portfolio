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

  all_updates_rule {
    # Notifications for all thresholds, SMS not supported
    monitoring_notification_channels = [
      data.terraform_remote_state.monitoring.outputs.email_channel_id,
    ]

    # The Pub/Sub-triggered Cloud Function will disconnect Billing at 100% spend
    pubsub_topic = data.terraform_remote_state.pubsub.outputs.budget_topic_id
  }

  budget_filter {
    custom_period {
      start_date {
        year  = 2024
        month = 1
        day   = 1
      }
      end_date {
        year  = 2025
        month = 12
        day   = 31
      }
    }
  }
}
