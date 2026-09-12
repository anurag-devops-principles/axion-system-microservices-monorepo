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

variable "security_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  description = "Security rules to apply to the network security group"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the network security group"
}
