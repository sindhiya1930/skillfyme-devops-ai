provider "aws" {
        region = var.aws_region
}

terraform {
        cloud {
                organization = "skillfyme"
                workspaces {
                        name = "standardized-config"
                }
        }
}

resource "aws_instance" "web" {
        ami = var.ami_id
        instance_type = var.instance_type
}
