provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "web" {
  ami           = "ami-037774efca2da0726"  
  instance_type = "t2.micro"
  #instance_type = "t2.small"
}
