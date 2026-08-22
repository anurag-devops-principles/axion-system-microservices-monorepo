variable "container_registry_name" {
  description = "The globally unique name of the Azure Container Registry."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the registry."
  type        = string
}

variable "location" {
  description = "The Azure region in which to create the registry."
  type        = string
}

variable "sku" {
  description = "The SKU of the Azure Container Registry."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "The ACR SKU must be Basic, Standard, or Premium."
  }
}

variable "admin_enabled" {
  description = "Whether to enable the ACR admin account. Managed identity should be used instead."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to the registry."
  type        = map(string)
  default     = {}
}
