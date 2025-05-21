terraform {
        required_version = ">= 1.3.0"
        cloud {
                organization = "skillfyme"
                workspaces {
                        name = "demo"
                }
        }
}

provider "aws" {
        region = var.aws_region
}
