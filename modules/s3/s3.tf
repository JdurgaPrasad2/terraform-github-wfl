resource "aws_s3_bucket" "resource" {
  bucket =  lower(var.bucket_name)
  tags = {
    "Name"                           = "${var.bucket_name}"
    "Project"                        = "${var.project}"
    "Environment"                    = "${var.env}"
  }
}

/*
resource "aws_s3_object" "object" {
    count = var.bucket_prefix == "" ? 0 : 1
    bucket = "${aws_s3_bucket.resource.id}"
    key    = var.bucket_prefix
} 
*/

resource "aws_s3_bucket_public_access_block" "block" {
  bucket                  = aws_s3_bucket.resource.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_notification" "bucket_sqs_notification" {
  count = var.bucket_sqs_notification ? 1 : 0
  bucket = aws_s3_bucket.resource.id
  queue {
    queue_arn     = var.sqs_queue_arn
    events        = var.bucket_events
    filter_suffix = var.filter_suffix
    filter_prefix = var.filter_prefix
  }
}
