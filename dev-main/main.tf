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

/*
locals{
  test = "${var.env == "test" ? "us-east-1" : ""}"
  dev = "${var.env == "dev" ? "us-east-2" : ""}"
  region = "${coalesce(local.test,local.dev)}"
}
*/

locals {
  compute_env_name                    = "${var.project}-${var.compute_env_name}-${var.env}"
  job_queue_name                      = "${var.project}-${var.job_queue_name}-${var.env}"
  job_def_name                        = "${var.project}-${var.job_def_name}-${var.env}"
  job_name                            = "${var.project}-${var.job_name}-${var.env}"
  batch_trigger_function_name         = "${var.project}-${var.batch_trigger_function_name}-${var.env}"
  batch_trigger_event_rule_name       = "${var.project}-${var.batch_trigger_event_rule_name}-${var.env}"
  batch_trigger_event_rule_desc       = "batch trigger event rule name"
  batch_trigger_event_schedule        = "${var.batch_trigger_event_schedule}"
  data_ingestion_bucket_name          = "${var.project}-${var.data_ingestion_bucket_name}-${var.env}"  
  data_ingestion_bucket_events        = []
  data_ingestion_bucket_filter_suffix = "null"
  data_ingestion_bucket_filter_prefix = "null"
  data_ingestion_bucket_sqs_notification = var.data_ingestion_bucket_sqs_notification
}

module "batch" {
  #count = var.env == "dev" ? 1 : 0
  source                = "../modules/batch"
  #providers             = { aws = aws.test }  
  project               = var.project
  region                = var.region
  env                   = var.env
  compute_env_name      = local.compute_env_name
  job_queue_name        = local.job_queue_name
  job_def_name          = local.job_def_name
  subnet_ids            = var.subnet_ids
  compute_resource_type = var.compute_resource_type
  compute_env_type      = var.compute_env_type
  job_queue_state       = var.job_queue_state
  ecr_app_code_image    = var.ecr_app_code_image
  assign_public_ip      = var.assign_public_ip
  job_def_type          = var.job_def_type
}
/*
module "batch" {
  #count = var.env == "test" ? 1 : 0
  source                = "../modules/batch"
  #providers             = { aws = aws.test }  
  project               = var.project
  region                = var.region
  env                   = var.env
  compute_env_name      = local.compute_env_name
  job_queue_name        = local.job_queue_name
  job_def_name          = local.job_def_name
  subnet_ids            = var.subnet_ids
  compute_resource_type = var.compute_resource_type
  compute_env_type      = var.compute_env_type
  job_queue_state       = var.job_queue_state
  ecr_app_code_image    = var.ecr_app_code_image
  assign_public_ip      = var.assign_public_ip
  job_def_type          = var.job_def_type
}
*/

module "lambda_batch_trigger" {
  source                  = "../modules/lambda"
  #providers             = { aws = aws.test }  
  project                 = var.project
  region                  = var.region  
  env                     = var.env
  function_name           = local.batch_trigger_function_name
  source_dir              = var.batch_trigger_src_dir
  output_path             = var.batch_trigger_src_op_path
  job_queue_name          = local.job_queue_name
  job_def_name            = local.job_def_name
  handler                 = "${var.batch_trigger_src_op_path}.lambda_handler"
  runtime                 = var.runtime
  job_name                = local.job_name
}

module "eventbridge_rule_batch_trigger" {
  depends_on = [module.lambda_batch_trigger]
  source                  = "../modules/eventbridge"
  #providers             = { aws = aws.test }  
  project                 = var.project
  region                  = var.region  
  env                     = var.env
  function_name           = local.batch_trigger_function_name
  function_arn           =  module.lambda_batch_trigger.lambda_arn
  event_rule_name         = local.batch_trigger_event_rule_name
  event_rule_desc         = local.batch_trigger_event_rule_desc
  event_schedule          = local.batch_trigger_event_schedule
}

module "data_ingestion_bucket" {
  source                      = "../modules/s3"
  #providers             = { aws = aws.test }  
  project                     = var.project
  region                      = var.region  
  env                         = var.env
  bucket_name                 = local.data_ingestion_bucket_name
  sqs_queue_arn               = var.sqs_queue_arn
  bucket_events               = var.data_ingestion_bucket_events
  filter_suffix               = var.data_ingestion_bucket_filter_suffix
  filter_prefix               = var.data_ingestion_bucket_filter_prefix
  bucket_sqs_notification     = var.data_ingestion_bucket_sqs_notification
}
