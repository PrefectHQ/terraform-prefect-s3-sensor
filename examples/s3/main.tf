provider "prefect" {}

provider "aws" {}

terraform {
  required_providers {
    prefect = {
      source = "prefecthq/prefect"
    }
  }
}

module "s3_to_prefect" {
  source      = "terraform-prefect-bucket-sensor"
  bucket_type = "s3"

  # Eventbridge S3 Event types:
  # https://docs.aws.amazon.com/AmazonS3/latest/userguide/EventBridge.html
  bucket_event_notification_types = ["Object Created", "Object Deleted"]

  bucket_name = "s3-to-prefect-source-bucket"
  topic_name  = "s3-to-prefect-event-topic"

  webhook_name = "s3-webhook"
  # Prefect Webhook templates:
  # https://docs.prefect.io/v3/automate/events/webhook-triggers#webhook-templates
  #
  # S3 Eventbridge Event Structure:
  # https://docs.aws.amazon.com/AmazonS3/latest/userguide/ev-events.html
  webhook_template = {
    event = "S3 {{ body.detail.reason }}",
    resource = {
      "prefect.resource.id" = "s3.bucket.{{ body.detail.bucket.name }}",
      "object-key"          = "{{ body.detail.object.key }}",
    }
  }
}
