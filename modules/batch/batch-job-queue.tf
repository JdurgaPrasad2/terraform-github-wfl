
#batch job queue

resource "aws_batch_job_queue" "job_queue" {
  name     = var.job_queue_name
  state    = var.job_queue_state
  priority = 1

  compute_environment_order {
    order               = 1
    compute_environment = aws_batch_compute_environment.compute_environment.arn
  }

  tags = {
    "Name"                           = "${var.job_queue_name}"
    "Project"                        = "${var.project}"
    "Environment"                    = "${var.env}"
  }

}
