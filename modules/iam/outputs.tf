# outputs.tf
output "iam_role_arn" {
  description = "Generated iam role arn"
  value       = aws_iam_role.lambda_execution.arn
}
