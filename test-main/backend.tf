terraform {
  backend "s3" {
    bucket = "s3-backend-for-testap"
    key =    "test/terraform.tfstate"
    region = "us-east-1"
    encrypt = true   
    dynamodb_table = "test-dynamodb-table"
    }
}
