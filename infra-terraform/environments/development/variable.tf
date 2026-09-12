variable "subnets" {
  description = "Subnets to create"
  type = map(object({
    subnet_name      = string
    address_prefixes = list(string)
  }))
}

variable "subnet-nsg" {
  type        = string
  description = "Key of the subnet (from var.subnets) to associate with the NSG (e.g. subnet_1)"
  default     = "subnet_1"
}

variable "subnet-nat-gw" {
  type        = string
  description = "Key of the subnet (from var.subnets) to associate with the NAT gateway (e.g. subnet_1)"
  default     = "subnet_1"
}
