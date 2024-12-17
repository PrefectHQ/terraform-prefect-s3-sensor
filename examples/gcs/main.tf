provider "prefect" {}

provider "google" {}

terraform {
  required_providers {
    prefect = {
      source = "prefecthq/prefect"
    }
  }
}

module "gcs_to_prefect" {
  source      = "terraform-prefect-bucket-sensor"
  bucket_type = "gcs"

  # GCS Event Notification Types:
  # https://cloud.google.com/storage/docs/pubsub-notifications#attributes
  bucket_event_notification_types = ["OBJECT_FINALIZE", "OBJECT_DELETE"]

  bucket_name = "gcs-to-prefect-source-bucket"
  topic_name  = "gcs-to-prefect-event-topic"

  # Prefect Webhook templates:
  # https://docs.prefect.io/v3/automate/events/webhook-triggers#webhook-templates
  #
  # GCS Event Notification Structure:
  # https://cloud.google.com/storage/docs/pubsub-notifications#attributes
  webhook_name = "gcs-webhook"
  webhook_template = {
    event = "GCS {{ body.message.attributes.eventType }}",
    resource = {
      "prefect.resource.id" = "gcs.bucket.{{ body.message.attributes.bucketId }}",
      "object-key"          = "{{ body.message.attributes.objectId }}",
    }
  }
}
