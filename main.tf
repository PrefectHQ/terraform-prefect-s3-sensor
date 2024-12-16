locals {
  default_webhook_templates = {
    # https://docs.aws.amazon.com/AmazonS3/latest/userguide/notification-content-structure.html
    s3 = {
      event_type  = "{{ body.Records[0].eventType }}"
      bucket_name = "{{ body.Records[0].s3.bucket.name }}"
      object_key  = "{{ body.Records[0].s3.object.key }}"
    }
    # https://cloud.google.com/storage/docs/pubsub-notifications
    gcs = {
      event_type  = "{{ body.eventType }}"
      bucket_name = "{{ body.bucketId }}"
      object_key  = "{{ body.objectId }}"
    }
  }
}

resource "prefect_webhook" "webhook" {
  name        = var.webhook_name
  description = "Webhook for cloud bucket event notifications"
  enabled     = true
  template    = coalesce(var.webhook_template, local.default_webhook_templates[var.cloud_provider])
}

module "s3" {
  source = "./modules/s3"
  count  = var.cloud_provider == "s3" ? 1 : 0

  bucket_name                     = var.bucket_name
  topic_name                      = var.topic_name
  bucket_event_notification_types = var.bucket_event_notification_types
  prefect_webhook_url             = "https://api.prefect.cloud${prefect_webhook.webhook.slug}"
}

module "gcs" {
  source = "./modules/gcs"
  count  = var.cloud_provider == "gcs" ? 1 : 0

  bucket_name                     = var.bucket_name
  topic_name                      = var.topic_name
  bucket_event_notification_types = var.bucket_event_notification_types
  prefect_webhook_url             = "https://api.prefect.cloud${prefect_webhook.webhook.slug}"
}
