# main.tf to call s3 bucket module
/*
module "test-s3" {
  source = "./modules/test-s3"
  department            = var.department
  env                   = var.env
  bucket_prefix         = var.bucket_prefix
  region                = var.region
}
*/

module "batch" {
  source                = "./modules/batch"
  project               = var.project
  region                = var.region
  env                   = var.env
  compute_env_name      = "${var.project}-${var.compute_env_name}-${var.env}"
  job_queue_name        = "${var.project}-${var.job_queue_name}-${var.env}"
  job_def_name          = "${var.project}-${var.job_def_name}-${var.env}"
  subnet_ids            = var.subnet_ids
  compute_resource_type = var.compute_resource_type
  compute_env_type      = var.compute_env_type
  job_queue_state       = var.job_queue_state
  ecr_app_code_image    = var.ecr_app_code_image
  assign_public_ip      = var.assign_public_ip
  job_def_type          = var.job_def_type
}

module "lambda-batch-trigger" {
  source                  = "./modules/Lambda"
  project                 = var.project
  region                  = var.region  
  env                     = var.env
  source_dir              = var.batch_trigger_src_dir
  output_path             = var.batch_trigger_src_op_path
  job_queue_name          = "${var.project}-${var.job_queue_name}-${var.env}"
  job_def_name            = "${var.project}-${var.job_def_name}-${var.env}"
  handler                 = "${var.batch_trigger_src_op_path}.lambda_handler"
  runtime                 = var.runtime
  job_name                = "${var.project}-${var.job_name}-${var.env}"
  #schedule-expression     = var.schedule-expression
}
