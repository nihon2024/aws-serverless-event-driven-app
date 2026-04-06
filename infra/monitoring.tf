resource "aws_cloudwatch_metric_alarm" "dlq_alarm" {
  alarm_name          = "dlq-messages-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = 60
  statistic           = "Average"
  threshold           = 0

  dimensions = {
    QueueName = aws_sqs_queue.dlq.name
  }

  alarm_description = "Alert when DLQ has messages"

  treat_missing_data = "notBreaching"
}