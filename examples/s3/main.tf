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
  source = "prefecthq/bucket-sensor/prefect//modules/s3"

  bucket_name = "s3-to-prefect-source-bucket"
  topic_name  = "s3-to-prefect-event-topic"

  bucket_event_notification_types = ["Object Created", "Object Deleted"]

  webhook_name = "s3-webhook"
  webhook_template = {
    event = "S3 {{ body.detail.reason }}",
    resource = {
      "prefect.resource.id" = "s3.bucket.{{ body.detail.bucket.name }}",
      "object-key"          = "{{ body.detail.object.key }}",
    }
  }
}

output "webhook_id" {
  value = module.s3_to_prefect.webhook.id
}
output "webhook_endpoint" {
  value = module.s3_to_prefect.webhook.endpoint
}
