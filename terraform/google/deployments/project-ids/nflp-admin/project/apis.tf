resource "google_project_service" "activate_apis" {
  for_each = toset(local.activate_apis)

  project = local.project
  service = each.key

  disable_on_destroy = false
}
