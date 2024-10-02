# outputs.tf
output "lambda_arn" {
  description = "Generated lambda arn"
  value       = aws_lambda_function.function.arn
}
