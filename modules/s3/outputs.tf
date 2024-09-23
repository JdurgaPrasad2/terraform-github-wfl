# outputs.tf
output "s3_bucket_name" {
  description = "Generated bucket name"
  value       = aws_s3_bucket.resource.id
}

output "s3_bucket_arn" {
  description = "Generated bucket aws resource name (arn)"
  value       = aws_s3_bucket.resource.arn
}
