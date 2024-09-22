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
  default = "testprefix/"
}
*/
##
##aws batch variables
##

variable "project" {
  description = "Department requesting the resource"
  type        = string
  default     = "doc"
}

variable "subnet_ids" {
  description = "list of compute resource subnet ids"
  type        = list(string)
  default     = ["subnet-00569b26a3213a7e1", "subnet-0e48b1f0e28e9c6c6", "subnet-0e026045fca978c88",
                 "subnet-0eec6807e479a7710", "subnet-0a7bc81164a4c83be", "subnet-08d6a2244363db01f"] 
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
  default = "311324824904.dkr.ecr.us-east-1.amazonaws.com/batchtest-repo:latest"
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
  default = ""
}

variable "job_name" {
  description = "batch job name"
  type = string
  default = ""
}
