# ==================================================
# Local Variables
# ==================================================
locals {
  _req_labels = {
    "handler" : "terraform"
    "function" : var.name
  }
  merged_labels = merge(var.labels, local._req_labels)
}


# ==================================================
# Optional Dedicated Bucket
# ==================================================
resource "google_storage_bucket" "source_archive" {
  count = var.create_dedicated_bucket ? 1 : 0

  project  = var.project
  name     = var.bucket_name
  location = var.bucket_location
  labels   = local.merged_labels

  # Security settings
  public_access_prevention = "enforced"

  versioning {
    enabled = true
  }
}

# ==================================================
# Source Archive from Bucket
# ==================================================
resource "google_storage_bucket_object" "archive" {
  name   = "index.zip"
  bucket = google_storage_bucket.source_archive.0.name # TODO: Use local and swap to correct bucket
  source = "./path/to/zip/file/which/contains/code"    # TODO
}

# ==================================================
# Cloud Function
# ==================================================
resource "google_cloudfunctions_function" "function" {
  project     = var.project
  name        = var.name
  runtime     = var.runtime
  entry_point = var.entry_point
  labels      = local.merged_labels

  trigger_http = false

  # Google Storage Source
  source_archive_bucket = var.bucket_name
  source_archive_object = var.source_archive_path
}

