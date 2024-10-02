resource "aws_dynamodb_table" "dynamodb-table" {
  name           = "${var.project}-${var.lambda_execution_role_name}-${var.env}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 3000
  write_capacity = 1000
  hash_key       = "Doc-Id"
  #range_key      = "Doc-Name"

  attribute {
    name = "Doc-Id"
    type = "S"
  }

  attribute {
    name = "Doc-Name"
    type = "S"
  }

  attribute {
    name = "Doc-Path"
    type = "S"
  }

  attribute {
    name = "Doc-Ingestion-Status"
    type = "S"
  }

  /*
  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  } */
  /*
  global_secondary_index {
    name               = ""
    hash_key           = ""
    range_key          = ""
    write_capacity     = ""
    read_capacity      = ""
    projection_type    = "INCLUDE"
    non_key_attributes = [""]
  } */

  tags = {
    "Name"                           = "${var.project}-${var.lambda_execution_role_name}-${var.env}"
    "Project"                        = "${var.project}"
    "Environment"                    = "${var.env}"
  }
}
