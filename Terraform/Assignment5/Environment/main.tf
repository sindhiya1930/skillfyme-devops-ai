resource "aws_vpc" "main" {
cidr_block = "10.${terraform.workspace == "prod" ? 2 : terraform.workspace == "staging" ? 1 : 0}.0.0/16"
enable_dns_support = true
enable_dns_hostnames = true

tags = merge(local.common_tags, {
Name = "vpc-${terraform.workspace}"
})
}

resource "aws_subnet" "subnet" {
vpc_id = aws_vpc.main.id
cidr_block = "10.${terraform.workspace == "prod" ? 2 : terraform.workspace == "staging" ? 1 : 0}.1.0/24"
availability_zone = "${var.aws_region}a"

tags = merge(local.common_tags, {
Name = "subnet-${terraform.workspace}"
})
}
