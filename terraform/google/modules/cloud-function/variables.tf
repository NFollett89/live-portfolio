# ==================================================
# Cloud Function Variables
# ==================================================
variable "project" {
  description = "The Project ID to create the resources in."
  type        = string
}

variable "name" {
  description = "A user-defined name of the function. Function names must be unique globally."
  type        = string
}

variable "runtime" {
  description = "The runtime in which the function is going to run. Eg. 'nodejs16', 'python39', 'dotnet3', 'go116', 'java11', 'ruby30', 'php74'. See: https://cloud.google.com/functions/docs/concepts/exec#runtimes"
  type        = string
}

variable "description" {
  description = "Description of the function"
  type        = string
  default     = ""
}

variable "region" {
  description = "The region where resources will be created."
  type        = string
}

variable "available_memory_mb" {
  description = " Memory (in MB), available to the function. Default value is 256. Possible values include 128, 256, 512, 1024, etc"
  type        = number
  default     = 256
}

variable "timeout" {
  description = "Timeout (in seconds) for the function. Default value is 60 seconds. Cannot be more than 540 seconds."
  type        = number
  default     = 60

  validation {
    condition     = var.timeout <= 540 && var.timeout >= 1
    error_message = "Variable 'timeout' must be between 1 and 540 seconds."
  }
}

variable "entry_point" {
  description = "Name of the function that will be executed when the Google Cloud Function is triggered."
  type        = string
  default     = "main"
}

variable "trigger_http" {
  description = "Whether to allow function execution to be triggered by HTTP. Supported HTTP request types are: POST, PUT, GET, DELETE, and OPTIONS. Cannot be used with event_trigger.
  type        = bool
  default     = false
}

variable "event_trigger" {
  description = "Event trigger configuration for the Google Cloud Function. For details on supported event types, see: https://cloud.google.com/functions/docs/calling/"

  type = object({
    event_type = string
    resource   = string
  })

  default = {
    event_type = ""
    resource   = ""
  }
}

variable "ingress_settings" {
  description = "String value that controls what traffic can reach the function. Allowed values are `ALLOW_ALL`, `ALLOW_INTERNAL_AND_GCLB` and `ALLOW_INTERNAL_ONLY`. Changes to this field will recreate the cloud function."
  type        = string
  default     = "ALLOW_INTERNAL_ONLY"
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the function."
  type        = map(string)
  default     = {}
}

# ==================================================
# Service Account Variables
# ==================================================
variable "service_account_email" {
  description = "If provided, the self-provided service account to run the function with. A dedicated Service Account will be created otherwise."
  type        = string
  default     = ""

  validation {
    condition = can(regex("^$|^[a-z0-9][a-z0-9-]{4,28}[a-z0-9]@[a-z0-9][a-z0-9-]{4,28}[a-z0-9]\\.iam\\.gserviceaccount\\.com$", var.service_account_email))

    error_message = "The service account email must be a valid Google service account email address ending in .iam.gserviceaccount.com"
  }
}

variable "dedicated_sa_name" {
  description = "The name to give the Service Account which will be generated specifically for the Cloud Function. Will soft-default to `{var.name}-sa`."
  type        = string
  default     = ""
}

# ==================================================
# Bucket Variables
# ==================================================
variable "create_dedicated_bucket" {
  description = "Whether a dedicated bucket should be created for the source archive. 'false' assumes that the Bucket referenced by variable `bucket_name` will already exist."
  type        = bool
  default     = false
}

variable "bucket_name" {
  description = "The name of the bucket to use for the source archive. If create_dedicated_bucket is true, this is the name of the new bucket. If false, this is the name of the existing bucket."
  type        = string
}

variable "source_archive_path" {
  description = "The path within the bucket where the source archive will be stored. Will soft default to a path based on the Prooject and Function name."
  type        = string
  default     = ""
}

variable "bucket_location" {
  description = "Location to create the optional dedicated bucket. Defaults to 'us-east1'."
  type        = string
  default     = "us-east1"
}

