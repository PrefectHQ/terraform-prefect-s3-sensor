variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket to create"
  default     = "s3-event-notification-bucket"
}

# https://docs.aws.amazon.com/AmazonS3/latest/userguide/EventBridge.html
variable "bucket_event_notification_types" {
  type        = list(string)
  description = "The types of S3 events to send notifications for"
  default     = ["Object Created", "Object Deleted"]
}

variable "topic_name" {
  type        = string
  description = "The name of the SNS topic to create"
  default     = "s3-event-notification-topic"
}

variable "prefect_webhook_url" {
  type        = string
  description = "The URL of the Prefect webhook to send notifications to"
}

variable "webhook_name" {
  type        = string
  description = "The name of the Prefect webhook"
  default     = "s3-webhook"
}

variable "webhook_template" {
  type        = map(any)
  description = "The template for the Prefect webhook payload. Defaults to a template for S3 events."
  default     = null
}
