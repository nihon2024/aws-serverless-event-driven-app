AWS Serverless Event-Driven Architecture (Terraform)

⸻

Overview

This project demonstrates a production-style serverless, event-driven architecture on AWS using Terraform.

It showcases how to build a scalable, decoupled system using core AWS services with proper failure handling, monitoring, and infrastructure as code.

⸻

Architecture

Flow:
	1.	Producer Lambda generates an event
	2.	EventBridge routes the event
	3.	Event is sent to SQS queue
	4.	Consumer Lambda processes the message
	5.	Data is stored in DynamoDB
	6.	Failed messages are sent to a Dead Letter Queue (DLQ)

⸻

Components
	•	AWS Lambda (Producer)
Simulates upstream events
	•	Amazon EventBridge
Routes events based on rules
	•	Amazon SQS
Buffers messages and enables decoupling
	•	AWS Lambda (Consumer)
Processes messages from SQS
	•	Amazon DynamoDB
Stores processed data
	•	Dead Letter Queue (DLQ)
Captures failed messages for analysis
	•	Amazon CloudWatch
Provides logs and monitoring with alarms

⸻

Key Features
	•	Event-driven architecture
	•	Asynchronous processing using SQS
	•	Service decoupling via EventBridge and SQS
	•	Failure handling using DLQ
	•	Idempotent consumer using DynamoDB conditional writes
	•	CloudWatch alarm for DLQ monitoring
	•	Infrastructure as Code using Terraform

⸻

Project Structure
aws-serverless-event-driven-app/
│
├── infra/
│   ├── provider.tf
│   ├── backend.tf
│   ├── lambda.tf
│   ├── eventbridge.tf
│   ├── sqs.tf
│   ├── dynamodb.tf
│   ├── s3.tf
│   ├── iam.tf
│   ├── monitoring.tf
│   ├── outputs.tf
│   └── variables.tf
│
├── lambda/
│   ├── producer/
│   └── consumer/
│       └── app.py
│
└── README.md

Terraform Backend

Remote state is stored using:
	•	S3 bucket (state storage)
	•	DynamoDB table (state locking)

⸻

Observability
	•	CloudWatch logs for Lambda functions
	•	CloudWatch alarm triggers when DLQ contains messages

⸻

Deployment

terraform init
terraform plan
terraform apply

Trigger event:

aws lambda invoke \
  --function-name aws-serverless-event-driven-producer \
  --payload '{}' \
  --cli-binary-format raw-in-base64-out \
  response.json

  Key Concepts Demonstrated
	•	Event-driven architecture
	•	Asynchronous processing (SQS)
	•	Service decoupling
	•	Failure handling with DLQ
	•	Idempotent processing
	•	Infrastructure as Code (Terraform)

⸻

Notes
	•	No Docker used (pure serverless implementation)
	•	Default region: us-east-1

⸻

Future Improvements
	•	Add CI/CD pipeline (GitHub Actions)
	•	Add API authentication (Amazon Cognito)
	•	Add monitoring dashboards (CloudWatch)
	•	Use Terraform modules for reusability

⸻

Trade-offs
	•	SQS chosen over direct Lambda invocation for better decoupling and reliability
	•	EventBridge enables flexible routing but adds slight latency
	•	At-least-once delivery from SQS requires idempotent consumer design

⸻

Author

Nitesh Kumar