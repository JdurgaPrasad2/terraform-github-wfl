'''
import json

def lambda_handler(event, context):
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
'''
import json
import boto3

def lambda_handler(event, context):
    
     # TODO implement
     batch_client = boto3.client('batch')
     sqs = boto3.client('sqs')
    
     queue_url = 'https://sqs.us-east-1.amazonaws.com/663026076425/binder-batch-trigger-sqs-test'
    
     job_definition_name = 'tst-batch-job-def-dev'
     job_queue_name =      'tst-batch-job-queue-dev'
    
     response = sqs.receive_message(
         QueueUrl=queue_url,
         AttributeNames=['All'],
         MaxNumberOfMessages=10,
         WaitTimeSeconds=10
     )
    
        
     messages = response.get('Messages', [])
     for message in messages:
         print(f"Received message: {message['Body']}")
         response = batch_client.submit_job(
                 jobName='tst-batch-job-test',
                 jobQueue=job_queue_name,
                 jobDefinition=job_definition_name,
                 retryStrategy={
                 'attempts': 1
                 },
         )
        
     for message in messages:
         sqs.delete_message(
             QueueUrl=queue_url,
             ReceiptHandle=message['ReceiptHandle']
     )

     return {
         'statusCode': 200,
         'body': json.dumps('Hello from Lambda!')
     }
