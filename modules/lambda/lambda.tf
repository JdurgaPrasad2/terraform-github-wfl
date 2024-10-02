#lambda source code zip 

data "archive_file" "lambda_source_code" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = "./${var.output_path}.zip"
} 

# lambda function 

resource "aws_lambda_function" "function" {
    function_name = var.function_name
    filename = data.archive_file.lambda_source_code.output_path
    source_code_hash = data.archive_file.lambda_source_code.output_base64sha256
    role = var.lambda_execution_role_arn
    handler = var.handler
    runtime = var.runtime 

    environment {
      variables = {
        job-def-name   = var.job_def_name
        job-queue-name = var.job_queue_name
        job-name       = var.job_name
        sqs-queue-url  = var.source_sqs_queue_url
        status-table-name = var.dynamodb_status_table_name
        status-table-arn  = var.dynamodb_status_table_arn
        ingestion-bucket-name = var.target_bucket_name
        ingestion-bucket-name = var.target_bucket_arn  
      }
    }
    tags = {
      "Name"                           = "${var.function_name}"
      "Project"                        = "${var.project}"
      "Environment"                    = "${var.env}"
    }
}
