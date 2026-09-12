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
}
