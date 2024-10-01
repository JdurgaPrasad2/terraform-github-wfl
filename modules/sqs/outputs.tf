# outputs.tf
output "s3_queue_arn" {
  description = "Generated sqs queue arn"
  value       = aws_sqs_queue.queue.arn
}

output "s3_queue_url" {
  description = "Generated sqs queue url"
  value       = aws_sqs_queue.queue.id
}
