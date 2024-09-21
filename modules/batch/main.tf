
locals {
  compute_env_name      = "${var.project}_${var.compute_env_name}_${var.env}"
  job_queue_name        = "${var.project}_${var.job_queue_name}_${var.env}"
  job_def_name          = "${var.project}_${var.job_def_name}_${var.env}"
}

## iam role and policies for batch compute environment 

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["batch.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "service_role" {
  name               = "${var.project}_batch_service_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "service_role" {
  role       = aws_iam_role.service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"
}

# security group for batch compute environment 

resource "aws_security_group" "compute_environment" {
  name = "${var.project}_batch_compute_env_${var.env}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## batch compute environment

resource "aws_batch_compute_environment" "compute_environment" {
  compute_environment_name = local.compute_env_name

  compute_resources {
    max_vcpus = 4

    security_group_ids = [
      aws_security_group.compute_environment.id
    ]

    subnets = var.subnet_ids

    type = var.compute_resource_type
  }

  service_role = aws_iam_role.service_role.arn
  type         = var.compute_env_type
  #depends_on   = [aws_iam_role_policy_attachment.service_role]
}

#batch job queue

resource "aws_batch_job_queue" "job_queue" {
  name     = local.job_queue_name
  state    = var.job_queue_state
  priority = 1

  compute_environment_order {
    order               = 1
    compute_environment = aws_batch_compute_environment.compute_environment.arn
  }
}
