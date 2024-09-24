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
  default     = "doc"
}

variable "bucket_name" {
    description = "s3 bucket name"
    type = string
}

variable "sqs_queue_arn" {
    description = "sqs queue arn"
    type = string
    default = null
}

variable "bucket_events" {
  description = "list of s3 events"
  type = list(string)
  default = []
}

variable "filter_suffix" {
  description = "s3 bucketnotification filter suffix"
  type = string
  default = null  
}

variable "filter_prefix" {
  description = "s3 bucketnotification filter prefix"
  type = string
  default = null  
}

variable "s3_bucket_sqs_notification" {
  description = "s3 bucket to sqs notification - true/false"
  type = bool
  default = false  
}


/*
variable "versioning" {
  type        = bool
  default     = false
}

variable "bucket_prefix" {
  description = "s3 bucket prefix folder path"
  type = string
}
*/
