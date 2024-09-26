terraform {
  backend "s3" {
    bucket = "s3-backend-for-testap"
    key =    "${var.env}/test.tfstate"
    region = "us-east-1"
    encrypt = true   
    #dynamodb_table = "test-dynamodb-table"
    dynamodb_table = "test-dynamodb-table-${var.env}"
    }
}
