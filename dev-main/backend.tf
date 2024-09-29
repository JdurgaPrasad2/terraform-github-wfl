terraform {
  backend "s3" {
    bucket = "s3-backend-for-testap"
    key =    "dev/dev.tfstate"
    region = "us-east-1"
    encrypt = true   
    dynamodb_table = "dynamodb-table"
    }
}
