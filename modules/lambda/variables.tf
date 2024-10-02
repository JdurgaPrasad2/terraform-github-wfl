# variables.tf

variable "env" {
  description = "Target environment for the deployment"
  type        = string
}

variable "region" {
  description = "Target region for the deployment"
  type        = string
}

variable "project" {
  description = "Department requesting the resource"
  type        = string
}

variable "handler" {
    description = "function handler"
    type = string
}

variable "runtime" {
    description = "runtime"
    type = string
}

variable "job_queue_name" {
  description = "job queue name"
  type = string
  default = ""
}

variable "job_def_name" {
  description = "job definition name"
  type = string
  default = ""
}

variable "job_name" {
  description = "batch job name"
  type = string
  default = ""
}

variable "source_sqs_queue_url" {
  description = "source sqs queue url for batch lambda"
  type = string
  default = ""
}

variable "target_bucket_arn" {
  description = "target bucket arn for ingestion lambda"
  type = string
  default = ""
}

variable "target_bucket_name" {
  description = "target bucketname for ingestion lambda"
  type = string
  default = ""
}

variable "source_dir" {
  description = "source dir"
  type = string
}

variable "output_path" {
  description = "source .zip file path"
  type = string
}

variable "function_name" {
  description = "lambda function name"
  type = string
}

variable "lambda_execution_role_arn" {
  description = "lambda execution role arn"
  type = string
}
