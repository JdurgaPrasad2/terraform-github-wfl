terraform {
  backend "s3" {
    bucket = "terraform-state-s3-backend"
    key =    "dev/dev.tfstate"
    region = "us-east-1"
    encrypt = true   
    dynamodb_table = "dynamodb-table"
    }
}
