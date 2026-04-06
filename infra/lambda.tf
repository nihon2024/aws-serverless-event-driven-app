resource "aws_lambda_function" "producer" {
  function_name = "aws-serverless-event-driven-producer"

  filename = "${path.module}/../lambda/producer/function.zip"
  handler  = "app.handler"
  runtime  = "python3.11"

  role = aws_iam_role.lambda_exec_role.arn

  source_code_hash = filebase64sha256("${path.module}/../lambda/producer/function.zip")
}

resource "aws_lambda_function" "consumer" {
  function_name = "aws-serverless-event-driven-consumer"

  filename = "${path.module}/../lambda/consumer/function.zip"
  handler  = "app.handler"
  runtime  = "python3.11"

  role = aws_iam_role.lambda_exec_role.arn

  source_code_hash = filebase64sha256("${path.module}/../lambda/consumer/function.zip")
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = aws_sqs_queue.event_queue.arn
  function_name    = aws_lambda_function.consumer.arn

  batch_size = 1
  enabled    = true
}
