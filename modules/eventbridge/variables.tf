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

variable "event_rule_name" {
    description = "event rule name"
    type = string
}

variable "event_rule_desc" {
    description = "event rule description"
    type = string
}

variable "event_schedule" {
  description = "event schedule"
  type = string
}

variable "function_name" {
  description = "lambda function name"
  type = string
}

variable "function_arn" {
  description = "lambda function arn"
  type = string
}
