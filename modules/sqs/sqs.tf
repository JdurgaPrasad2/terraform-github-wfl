data "aws_iam_policy_document" "queue" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["sqs:SendMessage"]
    resources = ["${aws_sqs_queue.queue.arn}"]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = ["${var.bucket_arn}"]
    }
  }
}

resource "aws_sqs_queue" "queue" {
  name                               = var.sqs_queue_name

  fifo_queue                         = var.fifo_queue_type_enabled
  fifo_throughput_limit              = var.fifo_queue_throughput_limit
  delay_seconds                      = var.queue_delay_seconds
  content_based_deduplication        = var.content_based_deduplication_enabled
  deduplication_scope                = var.deduplication_scope
  kms_data_key_reuse_period_seconds  = var.kms_data_key_reuse_period_seconds
  kms_master_key_id                  = var.kms_master_key_id
  max_message_size                   = var.max_message_size
  message_retention_seconds          = var.message_retention_seconds
  receive_wait_time_seconds          = var.receive_wait_time_seconds
  sqs_managed_sse_enabled            = var.sqs_managed_sse_enabled
  visibility_timeout_seconds         = var.visibility_timeout_seconds
  policy                             = data.aws_iam_policy_document.queue.json

  tags = {
      "Name"                           = var.sqs_queue_name
      "Environment"                    = var.env
      "Project   "                     = var.project
  }
}

