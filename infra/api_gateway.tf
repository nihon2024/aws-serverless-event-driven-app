# API Gateway is intentionally not implemented in this project.
# 
# This architecture is event-driven and uses a Lambda producer
# to simulate upstream events instead of an HTTP entry point.
#
# In a real-world scenario, API Gateway could be added as:
# Client → API Gateway → Lambda → EventBridge