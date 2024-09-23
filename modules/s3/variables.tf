# variables.tf
variable "env" {
  description = "Target environment for the deployment"
  type        = string
}

variable "region" {
  description = "Target region for the deployment"
  type        = string
}

variable "department" {
  description = "Department requesting the resource"
  type        = string
}

variable "versioning" {
  type        = bool
  default     = false
}

variable "bucket_prefix" {
  description = "s3 bucket prefix folder path"
  type = string
}
