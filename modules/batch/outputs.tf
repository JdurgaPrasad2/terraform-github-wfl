# outputs.tf
output "batch_compute_environment_arn" {
  description = "Generated batch compute environment arn"
  value       = aws_batch_compute_environment.compute_environment.arn
}

output "batch_job_queue_arn" {
  description = "Generated batch job queue arn"
  value       = aws_batch_job_queue.job_queue.arn
}

output "batch_job_definition_arn" {
  description = "Generated batch job definition arn"
  value       = aws_batch_job_definition.job_definition.arn
}

