resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket      = aws_s3_bucket.bucket.id
  eventbridge = true
}

resource "aws_cloudwatch_event_rule" "s3" {
  name        = "${var.bucket_name}-events-to-prefect"
  description = "Capture each S3 update to a Prefect webhook endpoint"

  event_pattern = jsonencode({
    source      = ["aws.s3"],
    detail-type = var.bucket_event_notification_types,
    detail = {
      bucket = {
        name = [var.bucket_name]
      }
    }
  })
}

resource "aws_cloudwatch_event_connection" "prefect" {
  name               = "prefect-webhook-connection"
  description        = "A connection to a Prefect webhook endpoint"
  authorization_type = "BASIC"

  auth_parameters {
    basic {
      username = "no-op"
      password = "no-op"
    }
  }
}

resource "aws_cloudwatch_event_api_destination" "prefect" {
  name                             = "prefect-webhook-api-destination"
  description                      = "An API Destination for a Prefect webhook endpoint"
  invocation_endpoint              = var.prefect_webhook_url
  http_method                      = "POST"
  invocation_rate_limit_per_second = 20
  connection_arn                   = aws_cloudwatch_event_connection.prefect.arn
}

resource "aws_iam_role" "eventbridge_invoke_api" {
  name = "${var.bucket_name}-eventbridge-api-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "eventbridge_invoke_api" {
  name = "${var.bucket_name}-eventbridge-api-policy"
  role = aws_iam_role.eventbridge_invoke_api.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["events:InvokeApiDestination"]
      Resource = ["*"]
    }]
  })
}

resource "aws_cloudwatch_event_target" "prefect" {
  rule     = aws_cloudwatch_event_rule.s3.name
  arn      = aws_cloudwatch_event_api_destination.prefect.arn
  role_arn = aws_iam_role.eventbridge_invoke_api.arn
}
