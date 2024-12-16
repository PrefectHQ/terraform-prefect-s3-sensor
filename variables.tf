variable "cloud_provider" {
  type = string
  validation {
    condition     = contains(["s3", "gcs"], var.cloud_provider)
    error_message = "The cloud provider must be either `s3` or `gcs`."
  }
  description = "The cloud provider where the bucket and notification infrastructure is provisioned. Either `s3` or `gcs`."
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket to create"
  default     = "sensor-bucket"
}

variable "bucket_event_notification_types" {
  type        = list(string)
  description = "The types of S3/GCP bucket events to send notifications for"
  # default     = ["s3:ObjectCreated:*"]
}

variable "topic_name" {
  type        = string
  description = "The name of the SNS or PubSub topic to create"
  default     = "topic"
}

# https://docs.aws.amazon.com/AmazonS3/latest/userguide/notification-content-structure.html
variable "webhook_template" {
  type        = string
  description = "The template for the webhook"
  default = {
    event_type  = "{{ body.Records[0].eventType }}"
    bucket_name = "{{ body.Records[0].s3.bucket.name }}"
    object_key  = "{{ body.Records[0].s3.object.key }}"
  }
}
