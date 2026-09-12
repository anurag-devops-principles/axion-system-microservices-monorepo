variable "virtual_network_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "region" {
  type        = string
  description = "Region of the virtual network"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name of the virtual network"
}

variable "address_space" {
  type        = list(string)
  description = "Address space of the virtual network"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the virtual network"
}
