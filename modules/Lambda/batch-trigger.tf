#create batch trigge source code zip 
data "archive_file" "zip_python_code" {
  type        = "zip"
  source_dir  = "./batch-trigger-source"
  output_path = "./batch-trigger-source"
} 

#lambda service assume policy
data "aws_iam_policy_document" "lambda_cloudwatch_logs_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

#lambda to cloudwatch-log role creation
resource "aws_iam_role" "lambda_cloudwatch_log_role" {
  name               = "sagerx-${var.department}-${var.env}-lambda-cloudwatch-log-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_cloudwatch_logs_assume.json
}

#lambda to cloudwatch-log policy creation  
data "aws_iam_policy_document" "lambda_cloudwatch_log_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
    ]

    resources = ["arn:aws:logs:${var.region}:${var.account}:*"]
  }

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:${var.region}:${var.account}:log-group:/aws/lambda/${aws_lambda_function.function.id}:*"]
  }

  statement {
    actions = [
      "workspaces:Describe*",
      "lambda:InvokeFunction",
    ]

    resources = ["*"]
  }

}

resource "aws_iam_role_policy" "lambda_cloudwatch_log_policy" {
  name   = "sagerx-${var.department}-${var.env}-lambda-cloudwatch-log-policy"
  policy = data.aws_iam_policy_document.lambda_cloudwatch_log_policy.json
  role   = aws_iam_role.lambda_cloudwatch_log_role.id
}

# create lambda function 
resource "aws_lambda_function" "function" {
    filename = data.archive_file.zip_python_code.output_path
    source_code_hash = data.archive_file.zip_python_code.output_base64sha256
    function_name = "sagerx-${var.department}-${var.env}-low-util-workspaces"
    role = aws_iam_role.lambda_cloudwatch_log_role.arn
    handler = var.handler
    runtime = var.runtime 
    environment {
      variables = {
        workspace_stale_days = var.workspace_stale_days
      }
    }
}

#create cloudwatch event bridge rule 
resource "aws_cloudwatch_event_rule" "schedule" {
    name = "sagerx-${var.department}-${var.env}-workspace-low-util-rule"
    description = "workspace low util rule "
    schedule_expression = var.schedule-expression
}
#attach event target for event bridge rule
resource "aws_cloudwatch_event_target" "check_target" {
    rule = aws_cloudwatch_event_rule.schedule.name
    target_id = "sagerx-${var.department}-${var.env}-low-util-workspaces"
    arn = aws_lambda_function.function.arn
    /*
    input = <<JSON
{
  "workspace_stale_days": "${var.workspace_stale_days}"
}
JSON  */
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "sagerx-${var.department}-${var.env}-low-util-workspaces"
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.schedule.arn
}
