# outputs.tf
output "role_arn" {
  description = "Generated iam role arn"
  value       = aws_iam_role.lambda_execution.arn
}

output "role_id" {
  description = "Generated iam role name"
  value       = aws_iam_role.lambda_execution.id
}
