resource "google_monitoring_notification_channel" "email_channel" {
  project      = local.project
  display_name = "Email Alert Channel"
  type         = "email"

  labels = {
    email_address = "nickfollett89@gmail.com"
  }
}
