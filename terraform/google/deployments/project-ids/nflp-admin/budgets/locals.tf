locals {
  project = "nflp-admin"

  # I expect to spend slowly, so would like gradual warnings
  thresholds = [0.25, 0.50, 0.75, 0.95, 1.0]
}
