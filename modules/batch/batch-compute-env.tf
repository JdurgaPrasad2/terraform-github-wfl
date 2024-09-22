# security group for batch compute environment 

resource "aws_security_group" "compute_environment" {
  name = var.compute_env_name

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## batch compute environment

resource "aws_batch_compute_environment" "compute_environment" {
  depends_on   = [aws_iam_role_policy_attachment.batch_service]  

  compute_environment_name = var.compute_env_name
  compute_resources {
    max_vcpus = 4

    security_group_ids = [
      aws_security_group.compute_environment.id
    ]

    subnets = var.subnet_ids

    type = var.compute_resource_type
  }

  service_role = aws_iam_role.batch_service.arn
  type         = var.compute_env_type

  tags = {
    "Name"                           = "${var.compute_env_name}"
    "Project"                        = "${var.project}"
    "Environment"                    = "${var.env}"
  }
}
