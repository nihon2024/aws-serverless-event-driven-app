resource "aws_dynamodb_table" "app_table" {
  name         = "aws-serverless-event-driven-app-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "orderId"

  attribute {
    name = "orderId"
    type = "S"
  }
}
