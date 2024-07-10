# Pull the Pub/Sub Topic name dynamically
data "terraform_remote_state" "pubsub" {
  backend = "gcs"

  config = {
    bucket = "nflp-tfstate"
    prefix = "state/pubsub"
  }
}

# Reference the Billing Account without exposing the unique ID
data "google_billing_account" "main" {
  display_name    = "nflp-billing"
  open            = true
  lookup_projects = false
}
