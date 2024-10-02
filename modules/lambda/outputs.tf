# outputs.tf
output "lambda_arn" {
  description = "Generated lambda arn"
  value       = aws_lambda_function.function.arn
}

output "lambda_id" {
  description = "Generated lambda fucntion id"
  value       = aws_lambda_function.function.id
}
