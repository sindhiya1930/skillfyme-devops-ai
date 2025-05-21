variable "production_ports" {
  type   = list(number)
  default = []
  validation {
    condition  = alltrue
