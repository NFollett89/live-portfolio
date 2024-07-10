# Pull the Pub/Sub Topic name
data "terraform_remote_state" "pubsub" {
  backend = "gcs"

  config = {
    bucket = "nflp-tfstate"
    prefix = "state/pubsub"
  }
}

# Pull the Email Notification channel
data "terraform_remote_state" "monitoring" {
  backend = "gcs"

  config = {
    bucket = "nflp-tfstate"
    prefix = "state/monitoring"
  }
}

# Reference the Billing Account without exposing the unique ID
data "google_billing_account" "main" {
  display_name    = "nflp-billing"
  open            = true
  lookup_projects = false
}
