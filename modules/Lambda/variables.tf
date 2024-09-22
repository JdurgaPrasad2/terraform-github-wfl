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
}

variable "job_def_name" {
  description = "job definition name"
  type = string
}

variable "job_name" {
  description = "batch job name"
  type = string
}

variable "batch_trigger_src_dir" {
  description = "batch jobtrigger source dir"
  type = string
}

variable "batch_trigger_src_op_path" {
  description = "batch jobtrigger source .zip file path"
  type = string
}

