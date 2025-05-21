variable "aws_region" {
        description = "The AWS region to deploy in"
        type        = string
        validation {
                condition = contains(["us-east-1", "us-west-2"], var.aws_region)
                error_message = "Region must be of the the aws approved regions"
        }
}

variable "key_pair_name" {
        description = "SSH key pair name"
        type        = string
        validation {
                condition = contains(["my-key", "devops-key"],var.key_pair_name)
                error_message = "Key pair must be on of the approved"
        }
}

variable "ami_id" {
        description = "The AMI ID to use for the ec2 instance"
        type        = string
}

variable "instance_type" {
        description = "The instance type of Ec2"
        type        = string
        validation {
                condition = contains(["t3.micro","t3.small"],var.instance_type)
                error_message = "Instance type not allowed"
        }
}
