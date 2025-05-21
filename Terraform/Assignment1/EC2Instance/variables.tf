variable "aws_region" {
        description = "The AWS region to deploy in"
        type        = string
        default     = "us-east-1"
}

variable "ami_id" {
        description = "The AMI ID to use for the ec2 instance"
        type        = string
}

variable "instance_type" {
        description = "The instance type of Ec2"
        type        = string
        default     = "t2.micro"
}
