variable "network_security_group_name" {
  type        = string
  description = "Name of the network security group"
}

variable "location" {
  type        = string
  description = "Location of the network security group"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name of the network security group"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the network security group"
}
