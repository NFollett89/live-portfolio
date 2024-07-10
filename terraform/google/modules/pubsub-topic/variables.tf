variable "project" {
  description = "The Project ID to create the resources in."
  type        = string
}

variable "topic_name" {
  description = "The name of the Pub/Sub Topic."
  type        = string
}

variable "labels" {
  description = "Labels to apply to the Pub/Sub Topic."
  type        = map(string)
  default     = {}
}

variable "message_retention_duration" {
  description = "How long to retain messages in backlog, from the time of publish. Default is 7 days."
  type        = string
  default     = "604800s"
}

variable "kms_key_name" {
  description = "The  name of the Cloud KMS CryptoKey to be used to protect access to messages published on this Topic. Soft defaults to the topic name with suffix '-key'."
  type        = string
  default     = ""
}

variable "keyring_location" {
  description = "The location for the KeyRing. A full list of valid locations can be found by running gcloud kms locations list."
  type        = string
  default     = "global"
}

variable "schema" {
  description = "The name of the schema that messages published should be validated against."
  type        = string
  default     = ""
}

variable "encoding" {
  description = "The encoding of messages validated against the schema."
  type        = string
  default     = "JSON"
}
