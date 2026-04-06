resource "aws_sqs_queue" "dlq" {
  name = "aws-serverless-event-driven-dlq"
}

resource "aws_sqs_queue" "event_queue" {
  name = "aws-serverless-event-driven-queue"

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 3
  })
}

resource "aws_sqs_queue_policy" "eventbridge_to_sqs" {
  queue_url = aws_sqs_queue.event_queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
        Action   = "sqs:SendMessage"
        Resource = aws_sqs_queue.event_queue.arn

        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_cloudwatch_event_rule.producer_rule.arn
          }
        }
      }
    ]
  })
}