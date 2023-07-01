resource "aws_cloudwatch_event_rule" "tf_event_rule" {
  name                = "my-event-rule"
  description         = "My EventBridge rule"
  schedule_expression = "cron(0 7,19 * * ? *)" # Runs at 7 AM and 7 PM

  event_pattern = <<PATTERN
{
  "source": ["aws.ec2"],
  "detail-type": ["EC2 Instance State-change Notification"],
  "detail": {
    "state": ["running", "stopped"]
  }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "sns_target" {
  rule      = aws_cloudwatch_event_rule.tf_event_rule.name
  arn       = aws_sns_topic.sns_topic.arn
  target_id = "EC2StateChange"
}

resource "aws_sns_topic" "sns_topic" {
  name = "sns-topic"
}

resource "aws_cloudwatch_event_target" "sqs_target" {
  rule      = aws_cloudwatch_event_rule.tf_event_rule.name
  arn       = aws_sqs_queue.sqs_queue.arn
  target_id = aws_instance.tr-task.id
}

resource "aws_sqs_queue" "sqs_queue" {
  name = "sqs-queue"
}

resource "aws_sns_topic_subscription" "subscription" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "sms"
  endpoint  = "+972546887886"
}