terraform {
  backend "gcs" {
    bucket = "nflp-tfstate"
    prefix = "state/project"
  }
}
