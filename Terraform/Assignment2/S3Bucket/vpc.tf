provider "aws" {
  region                  = "eu-west-3"
}

/*# Backend must remain commented until the Bucket
 and the DynamoDB table are created. 
 After the creation you can uncomment it,
 run "terraform init" and then "terraform apply" */

terraform {
  backend "s3" {
  bucket         = "angelo-terraform-state-backend-skillfy"
  key            = "terraform.tfstate"
  region         = "eu-west-3"
  dynamodb_table = "terraform_state"
  }
}

resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  tags = {
    Name = "vpc"
  }
}
