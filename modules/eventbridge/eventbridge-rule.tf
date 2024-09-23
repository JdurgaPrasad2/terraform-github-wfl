#event bridge-event rule 
resource "aws_cloudwatch_event_rule" "event_rule" {
    name                = var.event_rule_name
    description         = var.event_rule_desc
    schedule_expression = var.event_schedule
} 

#event bridge rule-event target
resource "aws_cloudwatch_event_target" "event_target" {
    rule      = aws_cloudwatch_event_rule.event_rule.name
    target_id = var.function_name
    arn       = var.function_arn
}

#lambda invoke permission to event rule
resource "aws_lambda_permission" "event_rule_lambda" {
    statement_id   = "AllowExecutionFromCloudWatch"
    action         = "lambda:InvokeFunction"
    function_name  = var.function_name
    principal      = "events.amazonaws.com"
    source_arn     = aws_cloudwatch_event_rule.event_rule.arn
}
