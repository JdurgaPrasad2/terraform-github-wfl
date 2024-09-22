
locals {
  job_def_name          = "${var.project}-${var.job_def_name}-${var.env}"
}

#batch job definition

resource "aws_batch_job_definition" "job_definition" {
  container_properties = jsonencode({
    command          = ["echo", "override this command from lambda function"]
    environment      = []
    executionRoleArn = aws_iam_role.batch_job_exec.arn
    fargatePlatformConfiguration = {
      platformVersion = "LATEST"
    }
    image       =  var.ecr_app_code_image
    jobRoleArn  = aws_iam_role.batch_job_exec.arn
    mountPoints = []
    networkConfiguration = {
      assignPublicIp = var.assign_public_ip
    }
    resourceRequirements = [{
      type  = "VCPU"
      value = "1.0"
      }, {
      type  = "MEMORY"
      value = "2048"
    }]
    secrets = []
    ulimits = []
    volumes = []
  })
  name                  = local.job_def_name
  parameters            = {}
  platform_capabilities = ["FARGATE"]
  propagate_tags        = false
  type                  = var.job_def_type
  retry_strategy {
    attempts = 1
  }
  timeout {
    attempt_duration_seconds = 300
  }
  tags = {
    "Name"                           = "${local.job_def_name}"
    "Project"                        = "${var.project}"
    "Environment"                    = "${var.env}"
  }
}
