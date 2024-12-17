# Prefect Bucket Sensor
Terraform module which creates an object storage bucket, event notifications, publishing topic, and a Prefect Webhook endpoint.

Use this module to provision an off-the-shelf bucket sensor integration to trigger Prefect automations and flows whenever bucket lifecycle events occur.

## Usage

```hcl
module "prefect_aws_bucket_sensor" {
  source = "prefecthq/bucket-sensor//modules/s3"
}

module "prefect_gcp_bucket_sensor" {
  source = "prefecthq/bucket-sensor//modules/gcs"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_prefect"></a> [prefect](#requirement\_prefect) | 2.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_prefect"></a> [prefect](#provider\_prefect) | 2.13.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gcs"></a> [gcs](#module\_gcs) | ./modules/gcs | n/a |
| <a name="module_s3"></a> [s3](#module\_s3) | ./modules/s3 | n/a |

## Resources

| Name | Type |
|------|------|
| [prefect_webhook.webhook](https://registry.terraform.io/providers/prefecthq/prefect/2.13.0/docs/resources/webhook) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_event_notification_types"></a> [bucket\_event\_notification\_types](#input\_bucket\_event\_notification\_types) | The types of S3/GCP bucket events to send notifications for | `list(string)` | n/a | yes |
| <a name="input_bucket_type"></a> [bucket\_type](#input\_bucket\_type) | The type of bucket to create. Either `s3` or `gcs`. | `string` | n/a | yes |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the bucket to create | `string` | `"sensor-bucket"` | no |
| <a name="input_topic_name"></a> [topic\_name](#input\_topic\_name) | The name of the SNS or PubSub topic to create | `string` | `"topic"` | no |
| <a name="input_webhook_name"></a> [webhook\_name](#input\_webhook\_name) | The name of the Prefect Webhook to create | `string` | `"bucket-sensor-webhook"` | no |
| <a name="input_webhook_template"></a> [webhook\_template](#input\_webhook\_template) | The template for the webhook | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_webhook_endpoint"></a> [webhook\_endpoint](#output\_webhook\_endpoint) | n/a |
<!-- END_TF_DOCS -->
