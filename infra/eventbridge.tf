resource "aws_cloudwatch_event_rule" "producer_rule" {
  name        = "producer-event-rule"
  description = "Capture events from producer lambda"

  event_pattern = jsonencode({
  source = ["app.producer"],
  "detail-type" = ["order_event"]
})
}

resource "aws_cloudwatch_event_target" "sqs_target" {
  rule      = aws_cloudwatch_event_rule.producer_rule.name
  target_id = "send-to-sqs"
  arn       = aws_sqs_queue.event_queue.arn

  depends_on = [
    aws_sqs_queue_policy.eventbridge_to_sqs
  ]
}