variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name of the subnet"
}

variable "address_prefixes" {
  type        = list(string)
  description = "Address prefixes of the subnet"
}

variable "virtual_network_name" {
  type        = string
  description = "Virtual network name of the subnet"
}
