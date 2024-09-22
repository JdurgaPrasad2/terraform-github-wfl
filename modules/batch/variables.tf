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

variable "subnet_ids" {
  description = "list of compute resource subnet ids"
  type        = list(string)
}

variable "compute_resource_type" {
  description = "batch compute resource type"
  type = string
}

variable "compute_env_type" {
  description = "batch compute environment type"
  type = string
}

variable "job_queue_state" {
  description = "job queue state"
  type = string
}
/*
variable "ecr_app_code_image" {
  description = "ecr - app code image"
  type = string
}

variable "assign_public_ip" {
  description = "assign public ip disabled or enabled"
  type = string
  default = "DISABLED"
}

variable "job_def_type" {
  description = "job def type "
  type = string
  default = "container"
}
*/
variable "compute_env_name" {
  description = "batch compute environment name"
  type = string
}

variable "job_queue_name" {
  description = "job queue name"
  type = string
}
/*
variable "job_def_name" {
  description = "job definition name"
  type = string
}
*/
