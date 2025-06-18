# variables.tf

variable "aws_region" {
  description = "The AWS region to deploy resources into."
  type        = string
  default     = "ap-south-1" # Default to Chennai (Mumbai region in AWS)
}

variable "project_name" {
  description = "The name of the project."
  type        = string
  default     = "Assignment5"
}

variable "cost_center" {
  description = "The cost center for resource allocation."
  type        = string
  default     = "IT-Ops"
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
  default     = "ami-0abcdef1234567890" # <<< IMPORTANT: Change this to a valid AMI for ap-south-1
                                       # e.g., for Amazon Linux 2 in ap-south-1: ami-0d86940735e5d179d (check current)
}
