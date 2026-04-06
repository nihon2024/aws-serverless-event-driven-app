import json
import boto3

print("🔥 MODULE LOADED")

eventbridge = boto3.client("events")

def handler(event, context):
    print("🔥 HANDLER STARTED")
    print("Received event:", event)

    response = eventbridge.put_events(
        Entries=[
            {
                "Source": "app.producer",
                "DetailType": "order_event",
                "Detail": json.dumps({"message": "hello from lambda"}),
                "EventBusName": "default"
            }
        ]
    )

    print("EventBridge response:", response)

    return {
        "statusCode": 200,
        "body": json.dumps({"message": "Event sent"})
    }