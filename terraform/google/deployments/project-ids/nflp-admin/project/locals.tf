locals {
  project = "nflp-admin"

  activate_apis = [
    "billingbudgets.googleapis.com",
    "cloudbilling.googleapis.com",
    "cloudkms.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "storage.googleapis.com",
    "pubsub.googleapis.com",
  ]
}
