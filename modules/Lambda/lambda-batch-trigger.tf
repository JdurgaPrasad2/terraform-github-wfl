#create batch trigge source code zip 

data "archive_file" "batch_trigger_source_code" {
  type        = "zip"
  source_dir  = "./batch-trigger-source"
  output_path = "./batch-trigger-source"
} 

# batch trigger lambda function 

resource "aws_lambda_function" "batch_trigger" {
    function_name = "${var.project}-low-util-workspaces-${var.env}"
    filename = data.archive_file.batch_trigger_source_code.output_path
    source_code_hash = data.archive_file.batch_trigger_source_code.output_base64sha256
    role = aws_iam_role.lambda_execution.arn
    handler = var.handler
    runtime = var.runtime 
    environment {
      variables = {
        job_def_name   = var.job_def_name
        job_queue_name = var.job_queue_name
        job_name       = var.job_name
      }
    }
}

/*
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
*/
