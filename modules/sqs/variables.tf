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

variable "bucket_arn" {
    description = "s3 bucket arn"
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

variable "bucket_sqs_notification" {
  description = "s3 bucket to sqs notification - true/false"
  type = bool
  default = false  
}
