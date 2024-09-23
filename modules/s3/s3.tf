resource "aws_s3_bucket" "resource" {
  bucket =  lower("testap-${var.department}-${var.env}")
}

resource "aws_s3_object" "object" {
    count = var.bucket_prefix == "" ? 0 : 1
    bucket = "${aws_s3_bucket.resource.id}"
    key    = var.bucket_prefix
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket                  = aws_s3_bucket.resource.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
