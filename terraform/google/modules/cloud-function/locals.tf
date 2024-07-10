locals {
  _req_labels = {
    "handler" : "terraform"
    "function" : var.name
  }
  merged_labels        = merge(var.labels, local._req_labels)
  dedicated_bucket     = google_storage_bucket.dedicated.0.name
  _default_source_path = "${var.project}/${var.runtime}/${var.name}"
}
