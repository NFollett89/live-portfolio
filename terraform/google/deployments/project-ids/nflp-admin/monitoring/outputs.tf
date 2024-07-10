output "email_channel_id" {
  description = "The ID for the Email Notification Channel"
  value       = google_monitoring_notification_channel.email_channel.id
}
