resource "aws_vpc" "main" {
cidr_block = var.cidr_block
enable_dns_support = true
enable_dns_hostnames = true

tags = merge(local.common_tags, {
Name = "vpc-${terraform.workspace}"
})
}

resource "aws_subnet" "subnet" {
vpc_id = aws_vpc.main.id
cidr_block = var.subnet_cidr
availability_zone = "${var.aws_region}a"

tags = merge(local.common_tags, {
Name = "subnet-${terraform.workspace}"
})
}
