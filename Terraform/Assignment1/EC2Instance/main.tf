provider "aws" {
        region = var.aws_region
}

resource "aws_instance" "web" {
        ami = var.ami_id
        instance_type = var.instance_type

        tags {
                Name = "TerraformEC2Instamce"
        }
}
