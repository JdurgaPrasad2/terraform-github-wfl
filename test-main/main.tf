provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "s3-backend-for-testap-test"
    key =    "test/terraform.tfstate"
    encrypt = true   
    dynamodb_table = "dynamodb-table-test"
    }
}

resource "aws_instance" "web" {
  ami           = "ami-037774efca2da0726"  
  instance_type = "t2.micro"
}
