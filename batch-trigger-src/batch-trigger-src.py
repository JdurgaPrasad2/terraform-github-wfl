import json

def lambda_handler(event, context):
    # TODO implement
    print(str(Square(4)))
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!'+ str(Square(4)))
    }
