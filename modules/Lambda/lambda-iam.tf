#lambda service assume policy
data "aws_iam_policy_document" "lambda_service_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

#lambda service role  
resource "aws_iam_role" "lambda_execution" {
  name               = "${var.project}-lambda-execution-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_service_assume.json
}

#lambda execution policy
data "aws_iam_policy_document" "lambda_execution" {
  statement {
    actions = [
      "logs:CreateLogGroup",
    ]

    resources = ["arn:aws:logs:${var.region}:311324824904:*"]
  }

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:${var.region}:311324824904:log-group:/aws/lambda/${aws_lambda_function.batch_trigger.id}:*"]
  }

  statement {
    actions = [
      "lambda:InvokeFunction"
    ]

    resources = ["*"]
  }

}

resource "aws_iam_role_policy" "lambda_execution" {
  name   = "${var.project}-lambda-execution-policy"
  policy = data.aws_iam_policy_document.lambda_execution.json
  role   = aws_iam_role.lambda_execution.id
}

resource "aws_iam_role_policy_attachment" "lambda_execution" {
  for_each = toset( [ "arn:aws:iam::aws:policy/AWSBatchFullAccess" ] )  
  role       =  aws_iam_role.lambda_execution.name
  policy_arn = each.key
}
