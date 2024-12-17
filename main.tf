locals {
  default_webhook_templates = {
    # https://docs.aws.amazon.com/AmazonS3/latest/userguide/notification-content-structure.html
    s3 = {
      event = "S3 {{ body.detail.reason }}",
      resource = {
        "prefect.resource.id" = "s3.bucket.{{ body.detail.bucket.name }}",
        "object-key"          = "{{ body.detail.object.key }}",
      }
    }
    # https://cloud.google.com/storage/docs/pubsub-notifications
    gcs = {
      event = "GCS {{ body.message.attributes.eventType }}",
      resource = {
        "prefect.resource.id" = "gcs.bucket.{{ body.message.attributes.bucketId }}",
        "object-key"          = "{{ body.message.attributes.objectId }}",
      }
    }
  }
}

resource "prefect_webhook" "webhook" {
  name        = var.webhook_name
  description = "Webhook for cloud bucket event notifications"
  enabled     = true
  template    = jsonencode(coalesce(var.webhook_template, local.default_webhook_templates[var.bucket_type]))
}

module "s3" {
  source = "./modules/s3"
  count  = var.bucket_type == "s3" ? 1 : 0

  bucket_name                     = var.bucket_name
  topic_name                      = var.topic_name
  bucket_event_notification_types = var.bucket_event_notification_types
  prefect_webhook_url             = prefect_webhook.webhook.endpoint
}

module "gcs" {
  source = "./modules/gcs"
  count  = var.bucket_type == "gcs" ? 1 : 0

  bucket_name                     = var.bucket_name
  topic_name                      = var.topic_name
  bucket_event_notification_types = var.bucket_event_notification_types
  prefect_webhook_url             = prefect_webhook.webhook.endpoint
}
