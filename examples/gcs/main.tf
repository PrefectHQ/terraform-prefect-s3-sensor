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
  source = "prefecthq/bucket-sensor/prefect//modules/gcs"

  bucket_name = "gcs-to-prefect-source-bucket"
  topic_name  = "gcs-to-prefect-event-topic"

  bucket_event_notification_types = ["OBJECT_FINALIZE", "OBJECT_DELETE"]

  webhook_name = "gcs-webhook"
  webhook_template = {
    event = "GCS {{ body.message.attributes.eventType }}",
    resource = {
      "prefect.resource.id" = "gcs.bucket.{{ body.message.attributes.bucketId }}",
      "object-key"          = "{{ body.message.attributes.objectId }}",
    }
  }
}

output "webhook_id" {
  value = module.gcs_to_prefect.webhook.id
}
output "webhook_endpoint" {
  value = module.gcs_to_prefect.webhook.endpoint
}
