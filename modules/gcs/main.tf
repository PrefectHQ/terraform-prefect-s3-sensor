resource "google_storage_notification" "notification" {
  bucket         = google_storage_bucket.bucket.name
  payload_format = "JSON_API_V1"
  topic          = google_pubsub_topic.topic.id
  event_types    = var.bucket_event_notification_types
  depends_on     = [google_pubsub_topic_iam_binding.binding]
}

// Enable notifications by giving the correct IAM permission to the unique service account.
data "google_storage_project_service_account" "gcs_account" {}

resource "google_pubsub_topic_iam_binding" "binding" {
  topic   = google_pubsub_topic.topic.id
  role    = "roles/pubsub.publisher"
  members = ["serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"]
}

resource "google_storage_bucket" "bucket" {
  name                        = var.bucket_name
  location                    = "US"
  uniform_bucket_level_access = true
}

resource "google_pubsub_topic" "topic" {
  name = var.topic_name
}

resource "google_pubsub_subscription" "subscription" {
  name  = "${var.topic_name}-subscription"
  topic = google_pubsub_topic.topic.id

  ack_deadline_seconds = 20

  push_config {
    push_endpoint = prefect_webhook.webhook.endpoint
  }
}

locals {
  default_webhook_template = {
    event = "GCS {{ body.message.attributes.eventType }}",
    resource = {
      "prefect.resource.id" = "gcs.bucket.{{ body.message.attributes.bucketId }}",
      "object-key"          = "{{ body.message.attributes.objectId }}",
    }
  }
}

resource "prefect_webhook" "webhook" {
  name        = var.webhook_name
  description = "Webhook for GCS bucket event notifications"
  enabled     = true
  template    = jsonencode(coalesce(var.webhook_template, local.default_webhook_template))
}
