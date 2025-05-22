resource "aws_security_group" "validated_sg" {
        name = "validated -secgroup"
        description = "SG created on Validation"
        vpc_id = "vpc-0aa7c74189a6b554e"

        dynamic "ingress" {
                for_each = var.allowed_ports
                content {
                        from_port = ingress.value
                        to_port = ingress.value
                        protocol = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
                }
        }
        egress {
                        from_port = 0
                        to_port = 0
                        protocol = "-1"
                        cidr_blocks = ["0.0.0.0/0"]
        }

        tags = {
                Name = "validated-sg"
        }
}
