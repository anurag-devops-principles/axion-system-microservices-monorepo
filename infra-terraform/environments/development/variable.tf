variable "subnets" {
  description = "Subnets to create"
  type = map(object({
    subnet_name      = string
    address_prefixes = list(string)
  }))
}

variable "aks_subnet" {
  type        = string
  description = "Key of the subnet (from var.subnets) to associate with the NSG (e.g. subnet_1)"
  default     = "subnet_1"
}

variable "appgw_subnet" {
  type        = string
  description = "Key of the subnet (from var.subnets) to associate with the application gateway (e.g. subnet_2)"
  default     = "subnet_2"
}

variable "role_assignment" {
  type = map(object({
    scope                = string
    role_defination_name = string
  }))
  description = "Map of role assignments"
}
