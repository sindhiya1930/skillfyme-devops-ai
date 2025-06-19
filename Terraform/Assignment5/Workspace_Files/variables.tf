# variables.tf

variable "aws_region" {
  description = "The AWS region to deploy resources into."
  type        = string
  default     = "us-east-1" # Default to Chennai (Mumbai region in AWS)
}

variable "environment_tag" {
  description = "The environment name (e.g., dev, staging, prod). This will be passed dynamically."
  type        = string
  nullable    = false # Ensure this variable is always set
}

# Variable for AMI ID, will be overridden by environment .tfvars if needed
variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
  type        = string
}

variable "instance_type" {
        description = "The instance type of Ec2"
        type        = string
        default     = "t2.micro"
}
