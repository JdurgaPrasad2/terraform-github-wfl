## iam role and policies for batch compute environment 

data "aws_iam_policy_document" "batch_service_assume" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["batch.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "batch_service" {
  name               = "${var.project}_batch_service_role"
  assume_role_policy = data.aws_iam_policy_document.batch_service_assume.json
}

resource "aws_iam_role_policy_attachment" "batch_service" {
  role       = aws_iam_role.batch_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"
}

## iam role and policies for batch job definition 

data "aws_iam_policy_document" "batch_job_exec_assume" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "batch_job_exec" {
  name               = "${var.project}_batch_job_exec_assume_role"
  assume_role_policy = data.aws_iam_policy_document.batch_job_exec_assume.json
}

resource "aws_iam_role_policy_attachment" "batch_job_exec" {
  for_each = toset( [ "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
                      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
                      "arn:aws:iam::aws:policy/AmazonS3FullAccess"
                    ])  
  role       =  aws_iam_role.batch_job_exec.name
  policy_arn = each.key
}
