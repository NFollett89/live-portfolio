#####################
### Pub/Sub Topic ###
#####################
resource "google_pubsub_topic" "topic" {
  project                    = var.project
  name                       = var.topic_name
  labels                     = local.merged_labels
  message_retention_duration = var.message_retention_duration
  kms_key_name               = google_kms_crypto_key.crypto_key.id

  dynamic "schema_settings" {
    for_each = var.schema != "" && var.encoding != "" ? [1] : []

    content {
      schema   = var.schema
      encoding = var.encoding
    }
  }

  depends_on = [
    google_kms_crypto_key_iam_binding.pubsub_kms_binding,
  ]
}

####################################
### Key Management Service (KMS) ###
####################################
resource "google_kms_key_ring" "key_ring" {
  project  = var.project
  name     = local.keyring_name
  location = var.keyring_location
}

resource "google_kms_crypto_key" "crypto_key" {
  name     = local.key_name
  key_ring = google_kms_key_ring.key_ring.id
  labels   = local.merged_labels
}

###################################
### Allow Pub/Sub SA to use KMS ###
###################################
data "google_project" "project_number" {
  project_id = var.project
}

resource "google_kms_crypto_key_iam_binding" "pubsub_kms_binding" {
  crypto_key_id = google_kms_crypto_key.crypto_key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members = [
    "serviceAccount:service-${data.google_project.project_number.number}@gcp-sa-pubsub.iam.gserviceaccount.com",
  ]
}
