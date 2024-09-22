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
  compute_env_name      = var.compute_env_name
  job_queue_name        = var.job_queue_name
  job_def_name          = var.job_def_name
  subnet_ids            = var.subnet_ids
  compute_resource_type = var.compute_resource_type
  compute_env_type      = var.compute_env_type
  job_queue_state       = var.job_queue_state
  ecr_app_code_image    = var.ecr_app_code_image
  assign_public_ip      = var.assign_public_ip
  job_def_type          = var.job_def_type
}

module "lambda-batch-trigger" {
  source                  = "./modules/lambda"
  project                 = var.project
  region                  = var.region  
  env                     = var.env
  job_queue_name          = var.job_queue_name
  job_def_name            = var.job_def_name
  zip-file-name           = "batch-trigger-source.zip"
  handler                 = "batch-trigger-source.lambda_handler"
  runtime                 = var.runtime
  schedule-expression     = var.schedule-expression
  workspace_stale_days    = var.workspace_stale_days
  cross_account_role_arn  = var.cross_account_role_arn
}
