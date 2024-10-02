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

variable "lambda_execution_role_name" {
  description = "lambda execution role name"
  type        = string
}

variable "lambda_function_id" {
  description = "lambda function id"
  type        = string
}

variable "lambda_execution_policy_name" {
  description = "lambda execution policy name"
  type        = string
}

variable "managed_policy_list_for_lambda" {
  description = "iam managed policy list for lambda"
  type        = string
}
