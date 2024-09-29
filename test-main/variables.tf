# variables.tf

variable "env" {
  description = "Target environment for the deployment"
  type        = string
  default     = "test"
} 

variable "region" {
  description = "Target region for the deployment"
  type        = string
  default     = "us-east-2"
}
/*
variable "department" {
  description = "Department requesting the resource"
  type        = string
  default = "test"
}

variable "versioning" {
  type        = bool
  default     = false
}

variable "bucket_prefix" {
  description = "s3 bucket prefix folder path"
  type = string
  default = "test/"
}
*/
##
##aws batch variables
##

variable "project" {
  description = "Department requesting the resource"
  type        = string
  default     = "binder"
}

variable "subnet_ids" {
  description = "list of compute resource subnet ids"
  type        = list(string)
  default     = ["subnet-1f35a774", "subnet-68063524", "subnet-b49c57c9"]
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
  default = "data-1x2-ingestion"  
}

variable "sqs_queue_arn" {
  description = "sqs queue arn"
  type = string
  default = null
}

variable "data_ingestion_bucket_events" {
  description = "list of s3 events for data ingestion bucket"
  type = list(string)
  default = []
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
  default = false  
}
/*
variable "env" {
    type        = map(object({
    region = string
  }))

  description = "DevOps AWS Account Numbers"
  default     = {
    "dev" = {
      "region" = "us-east-1"
    }
    "test" = {
      "region" = "us-east-2"
    }
  }
}

*/
