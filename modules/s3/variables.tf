variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket to create"
  default     = "s3-event-notification-bucket"
}

# https://docs.aws.amazon.com/AmazonS3/latest/userguide/notification-how-to-event-types-and-destinations.html#supported-notification-event-types
variable "bucket_event_notification_types" {
  type        = list(string)
  description = "The types of S3 events to send notifications for"
  default     = ["s3:ObjectCreated:*"]
}

variable "topic_name" {
  type        = string
  description = "The name of the SNS topic to create"
  default     = "s3-event-notification-topic"
}
