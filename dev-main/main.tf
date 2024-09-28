

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "s3-backend-for-testap"
    key =    "test/terraform.tfstate"
    encrypt = true   
    dynamodb_table = "test-dynamodb-table"
    }
}

resource "aws_instance" "web" {
  ami           = "ami-0e54eba7c51c234f6"
  instance_type = "t2.micro"
}

