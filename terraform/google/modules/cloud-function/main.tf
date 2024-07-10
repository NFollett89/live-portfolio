# ==================================================
# Optional Dedicated Bucket
# ==================================================
resource "google_storage_bucket" "dedicated" {
  count = var.create_dedicated_bucket ? 1 : 0

  name     = var.bucket_name
  project  = var.project
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
  bucket = local.dedicated_bucket
  source = "./path/to/zip/file/which/contains/code" # TODO
}

# ==================================================
# Cloud Function
# ==================================================
resource "google_cloudfunctions_function" "function" {
  project     = var.project
  name        = var.name
  region      = var.region
  runtime     = var.runtime
  entry_point = var.entry_point
  labels      = local.merged_labels

  trigger_http = false

  # Google Storage Source
  source_archive_bucket = var.bucket_name
  source_archive_object = local._default_source_path
}

