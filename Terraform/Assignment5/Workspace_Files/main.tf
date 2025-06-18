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
      name = `${terraform.workspace}`
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# --- Dynamic Configuration based on environment_tag ---
locals {
  # Instance type override based on the environment_tag variable
  instance_type_map = {
    "dev"     = "t2.micro"
    "staging" = "t3.small"
    "prod"    = "t3.medium"
  }

  selected_instance_type = lookup(local.instance_type_map, var.environment_tag, "t2.micro")

  # --- Tagging Standards ---
  common_tags = {
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Environment = var.environment_tag # Dynamically sets the Environment tag
    CostCenter  = var.cost_center
  }

  # Generate a random suffix for globally unique names (like S3 buckets)
  unique_suffix = random_string.suffix.result
}

# --- Resources to be deployed ---

resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
  numeric = true
}

resource "aws_vpc" "app_vpc" {
  # Unique CIDR block per environment based on environment_tag's length (simple example)
  # In a real scenario, you'd use a more robust network plan.
  cidr_block = "10.${length(var.environment_tag) + 10}.${index(split("", var.environment_tag), 0) + 20}.0/24"

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment_tag}-vpc"
  })
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.app_vpc.id
  # Unique subnet CIDR within the VPC
  cidr_block              = "10.${length(var.environment_tag) + 10}.${index(split("", var.environment_tag), 0) + 20}.0/28"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment_tag}-public-subnet"
  })
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.app_vpc.id

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment_tag}-igw"
  })
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment_tag}-public-rt"
  })
}

resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "web_sg" {
  name        = "${var.project_name}-${var.environment_tag}-web-sg"
  description = "Allow SSH and HTTP for ${var.environment_tag} environment"
  vpc_id      = aws_vpc.app_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: In production, restrict to known IPs!
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: In production, restrict to known IPs!
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment_tag}-web-sg"
  })
}

resource "aws_instance" "app_server" {
  ami           = var.ami_id # Using the ami_id variable
  instance_type = local.selected_instance_type # Dynamic instance type based on environment

  vpc_security_group_ids = [aws_security_group.web_sg.id]
  subnet_id              = aws_subnet.public_subnet.id

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment_tag}-app-server"
  })
}
