variable "bucket_name" {
  type        = string
  description = "The name of the GCS bucket to create"
  default     = "gcs-event-notification-bucket"
}

# https://cloud.google.com/storage/docs/pubsub-notifications#supported_event_types
variable "bucket_event_notification_types" {
  type        = list(string)
  description = "The types of GCS events to send notifications for"
  default     = ["OBJECT_FINALIZE", "OBJECT_METADATA_UPDATE"]
}

variable "topic_name" {
  type        = string
  description = "The name of the PubSub topic to create"
  default     = "gcs-event-notification-topic"
}

variable "prefect_webhook_url" {
  type        = string
  description = "The URL of the Prefect webhook to send notifications to"
}
