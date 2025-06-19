# main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  cloud {
    organization = "Skillfyme"
    workspaces {
      name = "assignment5-dev"
    }
  }
}
provider "aws" {
        region = var.aws_region
}

# --- Resources to be deployed ---
resource "aws_instance" "web" { {
  ami           = var.ami_id # Using the ami_id variable
  instance_type = var.instance_type

  tags ={
    Name = "${var.environment_tag}-app-server"
  }
}
