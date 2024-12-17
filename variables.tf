variable "bucket_type" {
  type = string
  validation {
    condition     = contains(["s3", "gcs"], var.bucket_type)
    error_message = "The bucket type must be either `s3` or `gcs`."
  }
  description = "The type of bucket to create. Either `s3` or `gcs`."
}

variable "webhook_name" {
  type        = string
  description = "The name of the Prefect Webhook to create"
  default     = "bucket-sensor-webhook"
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket to create"
  default     = "sensor-bucket"
}

variable "bucket_event_notification_types" {
  type        = list(string)
  description = "The types of S3/GCP bucket events to send notifications for"
}

variable "topic_name" {
  type        = string
  description = "The name of the SNS or PubSub topic to create"
  default     = "topic"
}

variable "webhook_template" {
  type        = map(any)
  description = "The template for the webhook"
  default     = null
}

