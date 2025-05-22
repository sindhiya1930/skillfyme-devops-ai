variable "allowed_ports" {
  description = "Ports to be added"
  type = list(number)
  validation {
    condition = alltrue([for port in var.allowed_ports: contains([22,443,80],ports)])
    error_message= "Valid ports are 22,80,443"
  }
}  
