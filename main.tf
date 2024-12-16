# Assume - we output the slug
resource "prefect_webhook" "webhook" {
  name        = "s3-event-notification-webhook"
  description = "Webhook for S3 event notifications"
  enabled     = true
  template    = jsonencode(var.webhook_template)
}

module "s3" {
  source = "./modules/s3"
  count  = var.type == "s3" ? 1 : 0

  bucket_name                     = var.bucket_name
  topic_name                      = var.topic_name
  bucket_event_notification_types = var.bucket_event_notification_types
  prefect_webhook_url             = "https://api.prefect.cloud${prefect_webhook.webhook.slug}"
}

module "gcs" {
  source = "./modules/gcs"
  count  = var.type == "gcs" ? 1 : 0

  bucket_name                     = var.bucket_name
  topic_name                      = var.topic_name
  bucket_event_notification_types = var.bucket_event_notification_types
  prefect_webhook_url             = "https://api.prefect.cloud${prefect_webhook.webhook.slug}"
}
