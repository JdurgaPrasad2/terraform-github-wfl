# outputs.tf
output "dynamodb_table_arn" {
  description = "Generated dynamodb table arn"
  value       = aws_dynamodb_table.status_table.arn
}

output "dynamodb_table_id" {
  description = "Generated dynamodb table id"
  value       = aws_dynamodb_table.status_table.id
}
