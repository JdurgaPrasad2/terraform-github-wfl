# outputs.tf
output "lambda_arn" {
  description = "Generated batch trigger lambda arn"
  value       = aws_lambda_function.function.arn
}
