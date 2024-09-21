# this module creates required iam role/policy for step-function 
/*
locals {
  stack_name = "${var.app_root}-${var.app_prefix}-${var.app_env}-${var.app_name}"
}

#assume role policy document for step function

data "aws_iam_policy_document" "step_function_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = var.aws_trusted_services
      type        = "Service"
    }
  }
}

#step function iam role

resource "aws_iam_role" "step_function" {
  name               = "${local.stack_name}-state-machine-role"
  assume_role_policy = data.aws_iam_policy_document.step_function_assume.json
}

#policy document for cloudwatch log access

data "aws_iam_policy_document" "cloudwatch_log" {
  statement {
    actions = [
      "logs:CreateLogDelivery",
      "logs:GetLogDelivery",
      "logs:UpdateLogDelivery",
      "logs:DeleteLogDelivery",
      "logs:ListLogDeliveries",
      "logs:PutResourcePolicy",
      "logs:DescribeResourcePolicies",
      "logs:DescribeLogGroups"
    ]
    resources = ["*"]
  }
}

#cloudwatch log access policy creation

resource "aws_iam_role_policy" "cloudwatch_log_policy" {
  name   = "${local.stack_name}-cloudwatch-log-policy"
  policy = data.aws_iam_policy_document.cloudwatch_log.json
  role   = aws_iam_role.step_function.id
}

#policy document for xray access

data "aws_iam_policy_document" "xray" {
  statement {
    actions = [
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords",
      "xray:GetSamplingRules",
      "xray:GetSamplingTargets"
    ]
    resources = ["*"]
  }
} 

#xray access policy creation

resource "aws_iam_role_policy" "xray_policy" {
  name   = "${local.stack_name}-xray-policy"
  policy = data.aws_iam_policy_document.xray.json
  role   = aws_iam_role.step_function.id
}

#policy document for lambda invoke access

data "aws_iam_policy_document" "lambda_invoke_function" {
  statement { 
    actions = [
      "lambda:InvokeFunction"
    ]
    resources = var.aws_lambda_arns
  }
}

#lambda invoke access policy creation

resource "aws_iam_role_policy" "lambda_invoke_policy" {
  name   = "${local.stack_name}-lambda-invoke-policy"
  policy = data.aws_iam_policy_document.lambda_invoke_function.json
  role   = aws_iam_role.step_function.id
}
*/

/*
resource "aws_sqs_queue" "sqs_queue" { 
  name                               = "${local.stack_name}-${var.queue_name}" 

  fifo_queue                         = var.fifo_queue_type_enabled
  fifo_throughput_limit              = var.fifo_queue_throughput_limit
  delay_seconds                      = var.queue_delay_seconds
  content_based_deduplication        = var.content_based_deduplication_enabled
  deduplication_scope                = var.deduplication_scope
  kms_data_key_reuse_period_seconds  = var.kms_data_key_reuse_period_seconds
  kms_master_key_id                  = var.kms_master_key_id
  max_message_size                   = var.max_message_size
  message_retention_seconds          = var.message_retention_seconds
  receive_wait_time_seconds          = var.receive_wait_time_seconds
  sqs_managed_sse_enabled            = var.sqs_managed_sse_enabled
  visibility_timeout_seconds         = var.visibility_timeout_seconds
  policy                             = var.queue_access_policy

  tags = {
    "Name"                           = "${local.stack_name}-${var.queue_name}"
    "Environment"                    = "${var.app_env}"
    "Department"                     = "${var.app_prefix}"
  }
}
*/
