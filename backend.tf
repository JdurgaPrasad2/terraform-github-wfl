terraform {
  backend "s3" {
    bucket = "s3-backend-for-testap"
    key =    "${var.env}/test.tfstate"
    region = var.region
    encrypt = true   
    #dynamodb_table = "test-dynamodb-table"
    dynamodb_table = "test-dynamodb-table-${var.env}"
    }
}
