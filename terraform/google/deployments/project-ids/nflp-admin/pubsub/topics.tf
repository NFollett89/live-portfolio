module "budget_topic" {
  source = "../../../../modules/pubsub-topic"

  project    = local.project
  topic_name = "budget"
}
