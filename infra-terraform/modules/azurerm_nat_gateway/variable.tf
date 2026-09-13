variable "name" {
  type        = string
  description = "Name of the NAT gateway"
}

variable "location" {
  type        = string
  description = "Location of the NAT gateway"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name of the NAT gateway"
}

variable "allocation_method" {
  type    = string
  default = "Static"
}

variable "sku" {
  type        = string
  description = "SKU of the NAT gateway"
  default     = "Standard"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the NAT gateway"
  default     = {}
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet to associate with the NAT gateway"
  default     = null
}
