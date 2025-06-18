# outputs.tf

output "ec2_instance_id" {
  description = "The ID of the deployed EC2 instance."
  value       = aws_instance.app_server.id
}

output "ec2_public_ip" {
  description = "The public IP address of the deployed EC2 instance."
  value       = aws_instance.app_server.public_ip
}

output "vpc_id" {
  description = "The ID of the deployed VPC."
  value       = aws_vpc.app_vpc.id
}

output "environment" {
  description = "The environment name for which resources were deployed."
  value       = var.environment_tag
}
