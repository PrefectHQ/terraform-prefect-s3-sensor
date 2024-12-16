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
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_prefect"></a> [prefect](#requirement\_prefect) | ~> 2.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_prefect"></a> [prefect](#provider\_prefect) | ~> 2.13 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gcs"></a> [gcs](#module\_gcs) | ./modules/gcs | n/a |
| <a name="module_s3"></a> [s3](#module\_s3) | ./modules/s3 | n/a |

## Resources

| Name | Type |
|------|------|
| [prefect_webhook.webhook](https://registry.terraform.io/providers/prefecthq/prefect/latest/docs/resources/webhook) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_event_notification_types"></a> [bucket\_event\_notification\_types](#input\_bucket\_event\_notification\_types) | The types of S3/GCP bucket events to send notifications for | `list(string)` | n/a | yes |
| <a name="input_cloud_provider"></a> [cloud\_provider](#input\_cloud\_provider) | The cloud provider where the bucket and notification infrastructure is provisioned. Either `s3` or `gcs`. | `string` | n/a | yes |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the bucket to create | `string` | `"sensor-bucket"` | no |
| <a name="input_topic_name"></a> [topic\_name](#input\_topic\_name) | The name of the SNS or PubSub topic to create | `string` | `"topic"` | no |
| <a name="input_webhook_template"></a> [webhook\_template](#input\_webhook\_template) | The template for the webhook | `string` | <pre>{<br/>  "bucket_name": "{{ body.Records[0].s3.bucket.name }}",<br/>  "event_type": "{{ body.Records[0].eventType }}",<br/>  "object_key": "{{ body.Records[0].s3.object.key }}"<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_webhook_url"></a> [webhook\_url](#output\_webhook\_url) | n/a |
<!-- END_TF_DOCS -->
