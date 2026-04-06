import json
import boto3

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table("aws-serverless-event-driven-app-table")

def handler(event, context):
    print("EVENT:", json.dumps(event))

    for record in event.get("Records", []):
        try:
            body = json.loads(record["body"])
            print("BODY:", body)

            # Validate
            if "id" not in body:
                print("Skipping: Missing id")
                continue

            if "detail" not in body:
                print("Skipping: Missing detail")
                continue

            order_id = body["id"]

            message = body["detail"].get(
                "message",
                body["detail"].get("eventName", "no-message")
            )

            # Idempotency
            table.put_item(
                Item={
                    "orderId": order_id,
                    "message": message
                },
                ConditionExpression="attribute_not_exists(orderId)"
            )

            print("Saved:", order_id)

        except Exception as e:
            print("Handled error:", str(e))
            continue

    return {"statusCode": 200}