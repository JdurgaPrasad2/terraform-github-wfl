#create batch trigge source code zip 
data "archive_file" "batch_trigger_source_code" {
  type        = "zip"
  source_dir  = "./batch-trigger-source"
  output_path = "./batch-trigger-source"
} 

#lambda service assume policy
data "aws_iam_policy_document" "lambda_service_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

#lambda service role  
resource "aws_iam_role" "lambda_execution" {
  name               = "${var.project}-lambda-execution-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_service_assume.json
}

#lambda execution policy
data "aws_iam_policy_document" "lambda_execution" {
  statement {
    actions = [
      "logs:CreateLogGroup",
    ]

    resources = ["arn:aws:logs:${var.region}:311324824904:*"]
  }

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:${var.region}:311324824904:log-group:/aws/lambda/${aws_lambda_function.batch_trigger.id}:*"]
  }

  statement {
    actions = [
      "lambda:InvokeFunction"
    ]

    resources = ["*"]
  }

}

resource "aws_iam_role_policy" "lambda_execution" {
  name   = "${var.project}-lambda-execution-policy"
  policy = data.aws_iam_policy_document.lambda_execution.json
  role   = aws_iam_role.lambda_execution.id
}

resource "aws_iam_role_policy_attachment" "lambda_execution" {
  for_each = toset( [ "arn:aws:iam::aws:policy/AWSBatchFullAccess" ] )  
  role       =  aws_iam_role.lambda_execution.name
  policy_arn = each.key
}

# batch trigger lambda function 
resource "aws_lambda_function" "batch_trigger" {
    function_name = "sagerx-${var.department}-${var.env}-low-util-workspaces"
    filename = data.archive_file.batch_trigger_source_code.output_path
    source_code_hash = data.archive_file.batch_trigger_source_code.output_base64sha256
    role = aws_iam_role.lambda_execution.arn
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
