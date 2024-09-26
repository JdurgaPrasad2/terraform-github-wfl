terraform {
  backend "s3" {
    bucket = "s3-backend-for-testap-test"
    key =    "test/test.tfstate"
    #region = us-east-1
    encrypt = true   
    #dynamodb_table = "test-dynamodb-table"
    dynamodb_table = "test-dynamodb-table-test"
    }
}
