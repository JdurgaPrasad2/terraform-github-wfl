import boto3
import json
import os

def lambda_handler(event, context):
    client = boto3.client("sns")
    job_name     = str(os.environ['job_name'])
    job_def_name = str(os.environ['job_def_name'])
    data = json.dumps(event, indent=4, separators=(", ", " = "))
    #del data['attempts', 'createdAt', 'retryStrategy', 'dependsOn', 'parameters', 'container'])
    #remove_list = [ "attempts", "createdAt", "retryStrategy", "dependsOn", "parameters", "container" ]
    #if key_to_remove in data:
    #remove_list = list(remove_list)
    #for key_to_remove in remove_list:
    #    if key_to_remove in data:
    #       data = data.pop(key_to_remove)
        #del data[key_to_remove]
    
    #print(json.dumps(ixh(TargetArn="arn:aws:sns:us-east-1:311324824904:batch-job-status", 
    #                , indent=4, separators=(". ", " = ")))
    #resp = client.publs      Message=str(json.dumps(event, indent=4, separators=(", ", " = "))), 
    #                      Subject="Batch Job: " + job_name + " FAILED")
    resp = client.publish(TargetArn="arn:aws:sns:us-east-1:311324824904:batch-job-status", 
                          Message=str(data), Subject="Batch Job: " + job_name + " FAILED")
