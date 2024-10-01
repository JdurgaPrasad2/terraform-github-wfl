# local varibales for main module 

locals{
  dev        = "${var.env == "dev" ?  "us-east-1" : ""}"
  test       = "${var.env == "test" ? "us-east-1" : ""}"
  #qa        = "${var.env == "test" ? "us-east-1" : ""}"
  #stage     = "${var.env == "test" ? "us-east-1" : ""}"
  #prod      = "${var.env == "test" ? "us-east-2" : ""}"
  region     = "${coalesce(local.dev,local.test)}"
}


locals {
  compute_env_name                    = "${var.project}-${var.compute_env_name}-${var.env}"
  job_queue_name                      = "${var.project}-${var.job_queue_name}-${var.env}"
  job_def_name                        = "${var.project}-${var.job_def_name}-${var.env}"
  job_name                            = "${var.project}-${var.job_name}-${var.env}"
  batch_trigger_function_name         = "${var.project}-${var.batch_trigger_function_name}-${var.env}"
  batch_trigger_event_rule_name       = "${var.project}-${var.batch_trigger_event_rule_name}-${var.env}"
  data_ingestion_bucket_name          = "${var.project}-${var.data_ingestion_bucket_name}-${var.env}"  
  ingestion_sqs_queue_name            = "${var.project}-${var.ingestion_sqs_queue_name}-${var.env}"  
  batch_trigger_event_rule_desc       = "batch trigger event rule name"
  batch_trigger_event_schedule        = "${var.batch_trigger_event_schedule}"
  data_ingestion_bucket_events        = "${var.data_ingestion_bucket_events}"
  data_ingestion_bucket_filter_suffix = "${var.data_ingestion_bucket_filter_suffix}"
  data_ingestion_bucket_filter_prefix = "${var.data_ingestion_bucket_filter_prefix}"
  data_ingestion_bucket_sqs_notification = var.data_ingestion_bucket_sqs_notification
}

# batch - job definition, job queue and compute environment 

module "batch" {
  source                = "../modules/batch"
  project               = var.project
  region                = local.region
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

# lambda to trigger batch 

module "lambda_batch_trigger" {
  source                  = "../modules/lambda"
  project                 = var.project
  region                  = local.region 
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

# eventbridge rule to invoke lambda which triggers batch

module "eventbridge_rule_batch_trigger" {
  depends_on = [module.lambda_batch_trigger]
  source                  = "../modules/eventbridge"
  project                 = var.project
  region                  = local.region  
  env                     = var.env
  function_name           = local.batch_trigger_function_name
  function_arn           =  module.lambda_batch_trigger.lambda_arn
  event_rule_name         = local.batch_trigger_event_rule_name
  event_rule_desc         = local.batch_trigger_event_rule_desc
  event_schedule          = local.batch_trigger_event_schedule
}

# ingestion sqs queue  

module "ingestion_sqs_queue" {
  source                      = "../modules/sqs"
  project                     = var.project
  region                      = local.region  
  env                         = var.env
  sqs_queue_name              = local.ingestion_sqs_queue_name
  #bucket_arn                  = module.data_ingestion_bucket.s3_bucket_arn
}

# ingestion s3 bucket

module "data_ingestion_bucket" {
  source                      = "../modules/s3"
  project                     = var.project
  region                      = local.region
  env                         = var.env
  bucket_name                 = local.data_ingestion_bucket_name
  sqs_queue_arn               = module.ingestion_sqs_queue.sqs_queue_arn
  bucket_events               = var.data_ingestion_bucket_events
  filter_suffix               = var.data_ingestion_bucket_filter_suffix
  filter_prefix               = var.data_ingestion_bucket_filter_prefix
  bucket_sqs_notification     = var.data_ingestion_bucket_sqs_notification
}

##sqs queue

locals {
  queue_access_policy = jsonencode(
      {
        "Version": "2012-10-17",
        "Id": "sqspolicy",
        "Statement": [{
          "Sid": "First",
          "Effect": "Allow",
          "Principal": "*",
          "Action": "sqs:SendMessage",
          "Resource": "${module.ingestion_sqs_queue.sqs_queue_arn}"
          "Condition": {
            "ArnEquals": {
              "aws:SourceArn": "${module.data_ingestion_bucket.s3_bucket_arn}"
            }
          }
        }]
      })
}

resource "aws_sqs_queue_policy" "queue_policy" {
  queue_url             = module.ingestion_sqs_queue.sqs_queue_url
  policy                = local.queue_access_policy
}


# lambda to trigger ingestion 

locals {
  ingestion_trigger_function_name         = "${var.project}-${var.ingestion_trigger_function_name}-${var.env}"
  ingestion_trigger_event_rule_name       = "${var.project}-${var.ingestion_trigger_event_rule_name}-${var.env}"
  ingestion_trigger_event_rule_desc       = "ingestion trigger event rule name"
  ingestion_trigger_event_schedule        = "${var.ingestion_trigger_event_schedule}"
}


module "lambda_ingestion_trigger" {
  source                  = "../modules/lambda"
  project                 = var.project
  region                  = local.region 
  env                     = var.env
  function_name           = local.ingestion_trigger_function_name 
  source_dir              = var.ingestion_trigger_src_dir
  output_path             = var.ingestion_trigger_src_op_path
  handler                 = "${var.ingestion_trigger_src_op_path}.lambda_handler"
  runtime                 = var.runtime
}

# eventbridge rule to invoke lambda which triggers batch

module "eventbridge_rule_batch_trigger" {
  depends_on = [module.lambda_batch_trigger]
  source                  = "../modules/eventbridge"
  project                 = var.project
  region                  = local.region  
  env                     = var.env
  function_name           = local.batch_trigger_function_name
  function_arn           =  module.lambda_batch_trigger.lambda_arn
  event_rule_name         = local.batch_trigger_event_rule_name
  event_rule_desc         = local.batch_trigger_event_rule_desc
  event_schedule          = local.batch_trigger_event_schedule
}





