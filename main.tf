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
  copute_env_name       = var.copute_env_name
  env                   = var.env
  subnet_ids            = var.subnet_ids
  compute_resource_type = var.compute_resource_type
  compute_env_type      = var.compute_env_type
}
