# variables.tf

variable "env" {
  description = "Target environment for the deployment"
  type        = string
  default     = "dev"
} 

variable "region" {
  description = "Target region for the deployment"
  type        = string
  default     = "us-east-1"
}


##aws batch variables


variable "project" {
  description = "Department requesting the resource"
  type        = string
  default     = "tst"
}

variable "subnet_ids" {
  description = "list of compute resource subnet ids"
  type        = list(string)
  default      = [""]
}

variable "compute_resource_type" {
  description = "batch compute resource type : ec2, spot, fargate or fargate_sport"
  type = string
  default = "FARGATE_SPOT"
}

variable "compute_env_type" {
  description = "batch compute environment type managed or unmanaged"
  type = string
  default = "MANAGED"
}

variable "job_queue_state" {
  description = "job queue state disabled or enabled"
  type = string
  default = "ENABLED"
}

variable "ecr_app_code_image" {
  description = "ecr - app code image"
  type = string
  default = ""
}

variable "assign_public_ip" {
  description = "assign public ip disabled or enabled"
  type = string
  default = "ENABLED"
}

variable "job_def_type" {
  description = "job def type "
  type = string
  default = "container"
}


variable "compute_env_name" {
  description = "batch compute environment name"
  type = string
  default = "batch-compute-env"
}

variable "job_queue_name" {
  description = "job queue name"
  type = string
  default = "batch-job-queue"
}

variable "job_def_name" {
  description = "job definition name"
  type = string
  default = "batch-job-def"
}

variable "handler" {
  description = "function handler"
  type = string
  default = ""
}

variable "runtime" {
  description = "runtime"
  type = string
  default = "python3.12"
}

variable "batch_trigger_src_dir" {
  description = "batch jobtrigger source dir"
  type = string
  default = "../batch-trigger-src"
}

variable "batch_trigger_src_op_path" {
  description = "batch jobtrigger source .zip file path"
  type = string
  default = "batch-trigger-src"
}

variable "batch_trigger_function_name" {
  description = "batch trigger function name"
  type = string
  default = "batch-trigger"
}

variable "batch_trigger_event_rule_name" {
  description = "batch trigger event rule name"
  type = string
  default = "batch-trigger-event-rule"
}

variable "batch_trigger_event_schedule" {
  description = "batch trigger event schedule"
  type = string
  default = "rate(2 hours)"
}

variable "job_name" {
  description = "batch job name"
  type = string
  default = "batch-job"
}

## s3 variables

variable "data_ingestion_bucket_name" {
  description = "s3 bucket name"
  type = string
  default = "data-ingestion"  
}
/* 
variable "sqs_queue_arn" {
  description = "sqs queue arn"
  type = string
  default = null
}
*/
variable "data_ingestion_bucket_events" {
  description = "list of s3 events for data ingestion bucket"
  type = list(string)
  default = ["s3:ObjectCreated:*"]
}

variable "data_ingestion_bucket_filter_suffix" {
  description = "s3 bucketnotification filter suffix"
  type = string
  default = null  
}

variable "data_ingestion_bucket_filter_prefix" {
  description = "s3 bucketnotification filter prefix"
  type = string
  default = null  
}

variable "data_ingestion_bucket_sqs_notification" {
  description = "s3 bucket to sqs notification - true/false"
  type = bool
  default = true  
}

variable "ingestion_sqs_queue_name" {
  description = "ingestion sqs queue name"
  type = string
  default = "ingestion-sqs-queue"
}

variable "ingestion_trigger_src_dir" {
  description = "ingestion lambda source dir"
  type = string
  default = "../ingestion-trigger-src"
}

variable "ingestion_trigger_src_op_path" {
  description = "ingestion trigger source .zip file path"
  type = string
  default = "ingestion-trigger-src"
}

variable "ingestion_trigger_function_name" {
  description = "ingestion trigger function name"
  type = string
  default = "ingestion-trigger"
}

variable "ingestion_trigger_event_rule_name" {
  description = "ingestion trigger event rule name"
  type = string
  default = "ingestion-trigger-event-rule"
}

variable "ingestion_trigger_event_schedule" {
  description = "ingestion trigger event schedule"
  type = string
  default = "rate(2 hours)"
}

variable "lambda_batch_execution_role_name" {
  description = "lambda batch execution role_name"
  type = string
  default = "lambda-batch-execution-role"
}

variable "lambda_batch_execution_policy_name" {
  description = "lambda batch execution policy name"
  type = string
  default = "lambda-batch-execution-policy"
}

variable "lambda_ingestion_execution_role_name" {
  description = "lambda ingestion execution role_name"
  type = string
  default = "lambda-ingestion-execution-role"
}

variable "lambda_ingestion_execution_policy_name" {
  description = "lambda ingestion execution policy name"
  type = string
  default = "lambda-ingestion-execution-policy"
}
