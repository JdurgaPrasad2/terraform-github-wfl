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
  default     = "binder"
}
/*
variable "bucket_arn" {
    description = "s3 bucket arn"
    type = string
} */

variable "sqs_queue_name" {
    description = "sqs queue name"
    type = string
}

variable "fifo_queue_type_enabled" {
  description = "sqs queue type fifo enabled?"
  type = string
  default = "false" 
}

variable "fifo_queue_throughput_limit" {
  description = "sqs fifo throughput limit"
  type = string
  default = null 
}

variable "queue_delay_seconds" {
  description = "sqs queue deplay in seconds"
  type = number
  default = 0 
}

variable "content_based_deduplication_enabled" {
  description = "sqs queue with content based deduplication enabled?"
  type = string
  default = "false" 
}

variable "deduplication_scope" {
  description = "sqs deduplication scope"
  type = string
  default = null 
}

variable "kms_data_key_reuse_period_seconds" {
  description = "kms data_key reuse period seconds"
  type = number
  default = 300 
}

variable "kms_master_key_id" {
  description = "kms master key_id"
  type = string
  default = null 
}

variable "max_message_size" {
  description = "sqs queue max message size"
  type = number
  default = 262144 
}

variable "message_retention_seconds" {
  description = "sqs queue message retention seconds"
  type = number
  default = 345600 
}

variable "receive_wait_time_seconds" {
  description = "queue message receive wait_time seconds"
  type = number
  default = 0 
}

variable "sqs_managed_sse_enabled" {
  description = "sqs managed sse enabled?"
  type = string
  default = "true" 
}

variable "visibility_timeout_seconds" {
  description = "queue message visibility timeout seconds"
  type = number
  default = 30 
}

variable "queue_access_policy" {
  type        = string
  description = "sqs queue access policy"
  default     = ""
}

