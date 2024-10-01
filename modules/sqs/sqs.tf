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
  name   = var.sqs_queue_name
  policy = data.aws_iam_policy_document.queue.json
}
