variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket to create"
  default     = "s3-event-notification-bucket"
}

# https://docs.aws.amazon.com/AmazonS3/latest/userguide/EventBridge.html
variable "bucket_event_notification_types" {
  type        = list(string)
  description = "The types of S3 events to send notifications for. See [documentation](https://docs.aws.amazon.com/AmazonS3/latest/userguide/EventBridge.html) for supported event types"
  default     = ["Object Created", "Object Deleted"]
}

variable "topic_name" {
  type        = string
  description = "The name of the SNS topic to create"
  default     = "s3-event-notification-topic"
}

variable "webhook_name" {
  type        = string
  description = "The name of the Prefect webhook"
  default     = "s3-webhook"
}

variable "webhook_template" {
  type        = any
  description = "The template for the Prefect webhook payload. Defaults to a template for S3 events"
  default     = null
}
