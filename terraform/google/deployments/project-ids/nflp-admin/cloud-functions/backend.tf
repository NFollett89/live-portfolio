terraform {
  backend "gcs" {
    bucket = "nflp-tfstate"
    prefix = "state/cloud-functions"
  }
}
