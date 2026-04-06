terraform {
  backend "s3" {
    bucket         = "aws-serverless-event-driven-app"
    key            = "serverless-app/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "aws-serverless-event-driven-app-locks"
    encrypt        = true
  }
}