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

variable "dynamodb_table_name" {
  description = "dynamodb table name"
  type        = string
}

