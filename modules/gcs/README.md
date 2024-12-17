<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 6.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.12.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_pubsub_subscription.subscription](https://registry.terraform.io/providers/hashicorp/google/6.12.0/docs/resources/pubsub_subscription) | resource |
| [google_pubsub_topic.topic](https://registry.terraform.io/providers/hashicorp/google/6.12.0/docs/resources/pubsub_topic) | resource |
| [google_pubsub_topic_iam_binding.binding](https://registry.terraform.io/providers/hashicorp/google/6.12.0/docs/resources/pubsub_topic_iam_binding) | resource |
| [google_storage_bucket.bucket](https://registry.terraform.io/providers/hashicorp/google/6.12.0/docs/resources/storage_bucket) | resource |
| [google_storage_notification.notification](https://registry.terraform.io/providers/hashicorp/google/6.12.0/docs/resources/storage_notification) | resource |
| [google_storage_project_service_account.gcs_account](https://registry.terraform.io/providers/hashicorp/google/6.12.0/docs/data-sources/storage_project_service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_prefect_webhook_url"></a> [prefect\_webhook\_url](#input\_prefect\_webhook\_url) | The URL of the Prefect webhook to send notifications to | `string` | n/a | yes |
| <a name="input_bucket_event_notification_types"></a> [bucket\_event\_notification\_types](#input\_bucket\_event\_notification\_types) | The types of GCS events to send notifications for | `list(string)` | <pre>[<br/>  "OBJECT_FINALIZE",<br/>  "OBJECT_METADATA_UPDATE"<br/>]</pre> | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the GCS bucket to create | `string` | `"gcs-event-notification-bucket"` | no |
| <a name="input_topic_name"></a> [topic\_name](#input\_topic\_name) | The name of the PubSub topic to create | `string` | `"gcs-event-notification-topic"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->