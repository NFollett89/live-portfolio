output "topic_id" {
  description = "The Pub/Sub Topic ID"
  value       = google_pubsub_topic.topic.id
}
