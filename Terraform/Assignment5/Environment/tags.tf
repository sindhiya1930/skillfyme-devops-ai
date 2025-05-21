locals {
        common_tags = {
                Project  = "Terraform-AWS"
                Environment = terraform.workspace
                Owner    = "devops-team"
        }
}
