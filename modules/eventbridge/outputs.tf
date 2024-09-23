# outputs.tf
output "event_rule_arn" {
  description = "Generated event bridge event rule arn"
  value       = aws_cloudwatch_event_rule.event_rule.arn
}
