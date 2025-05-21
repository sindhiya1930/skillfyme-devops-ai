output "instance_public_ip" {
        description = "The public IP"
        value       = aws_instance.web.public_ip
}
