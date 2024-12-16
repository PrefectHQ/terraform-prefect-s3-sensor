data "aws_iam_policy_document" "topic" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions   = ["SNS:Publish"]
    resources = ["arn:aws:sns:*:*:s3-event-notification-topic"]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = [aws_s3_bucket.bucket.arn]
    }
  }
}
resource "aws_sns_topic" "topic" {
  name   = var.topic_name
  policy = data.aws_iam_policy_document.topic.json
}

# we might not need to provision this, maybe make this optional?
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  topic {
    topic_arn     = aws_sns_topic.topic.arn
    events        = var.bucket_event_notification_types
    filter_suffix = ".log"
  }
}

resource "aws_sns_topic_subscription" "s3_event_notification_target" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "https"
  endpoint  = var.prefect_webhook_url
}

