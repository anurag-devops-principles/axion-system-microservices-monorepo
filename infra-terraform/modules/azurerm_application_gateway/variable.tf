variable "name" {
  type        = string
  description = "Name of the application gateway"
}

variable "location" {
  type        = string
  description = "Location of the application gateway"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name of the application gateway"
}

variable "allocation_method" {
  type    = string
  default = "Static"
}

variable "sku" {
  type        = string
  description = "SKU of the appgw public IP"
  default     = "Standard"
}

variable "sku_name" {
  type        = string
  description = "SKU name of the application gateway (e.g. Standard_v2, WAF_v2)"
  default     = "Standard_v2"
}

variable "sku_tier" {
  type        = string
  description = "SKU tier of the application gateway (e.g. Standard_v2, WAF_v2)"
  default     = "Standard_v2"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet to associate with the application gateway"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the application gateway"
  default     = {}
}
