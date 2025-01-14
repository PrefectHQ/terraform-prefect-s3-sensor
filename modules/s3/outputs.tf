output "webhook" {
  description = "The Prefect webhook resource. Use the metadata to get the endpoint or webhook ID for downstream Automations"
  value       = prefect_webhook.webhook
}
