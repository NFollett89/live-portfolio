output "budget_topic_id" {
  description = "The Pub/Sub Topic ID used for Budgets"
  value       = module.budget_topic.topic_id
}
