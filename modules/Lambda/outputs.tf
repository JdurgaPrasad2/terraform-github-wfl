# outputs.tf
output "lambda_batch_trigger_arn" {
  description = "Generated batch trigger lambda arn"
  value       = aws_lambda_function.batch_trigger.arn
}
