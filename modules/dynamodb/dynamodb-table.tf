resource "aws_dynamodb_table" "status_table" {
  name           = "${var.project}-${var.dynamodb_table_name}-${var.env}"
  billing_mode   = "PROVISIONED"
  read_capacity  = "3000"
  write_capacity = "1000"
  hash_key       = "Doc-Id"
  range_key      = "Doc-Name"

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
  
  global_secondary_index {
    name               = "Doc-Id-Index"
    hash_key           = "Doc-Id"
    range_key          = "Doc-Name"
    write_capacity     = "1000"
    read_capacity      = "3000"
    projection_type    = "INCLUDE"
    non_key_attributes = ["Doc-Id"]
  } 

  tags = {
    "Name"                           = "${var.project}-${var.dynamodb_table_name}-${var.env}"
    "Project"                        = "${var.project}"
    "Environment"                    = "${var.env}"
  }
}
