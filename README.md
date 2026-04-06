AWS Serverless Event-Driven Architecture (Terraform)

⸻

🚀 Overview

This project provisions a production-style serverless, event-driven architecture on AWS using Terraform.

It demonstrates how to build a scalable and decoupled system using modern AWS services such as API Gateway, Lambda, EventBridge, SQS, DynamoDB, and S3.

The infrastructure is fully managed using Infrastructure as Code (Terraform) and version-controlled with Git/GitHub.

⸻

🧰 Tech Stack
	•	AWS (API Gateway, Lambda, EventBridge, SQS, DynamoDB, S3, IAM, CloudWatch)
	•	Terraform (Infrastructure as Code)
	•	Git & GitHub (Version control)
	•	VS Code (Development environment)
	•	Terminal (zsh)

⸻

🏗️ Architecture

Flow:
	1.	Client sends request to API Gateway
	2.	API Gateway triggers Lambda (Producer)
	3.	Lambda publishes event to EventBridge
	4.	EventBridge routes event to SQS queue
	5.	Lambda (Consumer) processes messages from SQS
	6.	Processed data is stored in DynamoDB
	7.	Raw payloads / logs can be stored in S3
	8.	Failed messages are sent to Dead Letter Queue (DLQ)

⸻

📁 Project Structure

aws-serverless-event-driven-app/
├── infra/
│   ├── backend.tf
│   ├── provider.tf
│   ├── api_gateway.tf
│   ├── lambda.tf
│   ├── eventbridge.tf
│   ├── sqs.tf
│   ├── dynamodb.tf
│   ├── s3.tf
│   ├── iam.tf
│   ├── outputs.tf
│   └── variables.tf
│
├── lambda/
│   ├── producer/
│   │   └── app.py
│   └── consumer/
│       └── app.py
│
└── README.md

Security Design
	•	IAM roles with least privilege access
	•	SQS decouples services to improve resilience
	•	DLQ for failure handling
	•	No direct service-to-service tight coupling

⸻

📦 Terraform Backend

Remote state is stored using:
	•	S3 bucket (state storage)
	•	DynamoDB table (state locking)

⸻

📊 Observability
	•	AWS CloudWatch Logs for Lambda and API Gateway
	•	Helps monitor execution and debug failures

⸻

⚙️ Deployment Steps
terraform init
terraform plan
terraform apply

Key Concepts Demonstrated
	•	Event-driven architecture
	•	Asynchronous processing (SQS)
	•	Service decoupling (EventBridge)
	•	Failure handling (DLQ)
	•	Infrastructure as Code (Terraform)

⸻

📌 Notes
	•	Default region: us-east-1
	•	Database is DynamoDB (serverless)
	•	No Docker used (pure serverless implementation)

⸻

🚀 Future Improvements
	•	Add CI/CD pipeline (GitHub Actions)
	•	Add API authentication (Cognito)
	•	Add monitoring dashboards (CloudWatch)
	•	Use Terraform modules for reusability

    Author
    Nitesh Kumar 
