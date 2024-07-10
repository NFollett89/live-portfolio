locals {
  # Handle labels
  _req_labels = {
    "handler" : "terraform"
  }
  merged_labels = merge(var.labels, local._req_labels)

  # Naming for KMS resources
  _name_prefix = var.kms_key_name != "" ? var.kms_key_name : var.topic_name
  key_name     = "${local._name_prefix}-key"
  keyring_name = "${local._name_prefix}-keyring"
}
