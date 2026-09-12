variable "uami_name" {
  type        = string
  description = "Name of the user-assigned managed identity"
}

variable "location" {
  type        = string
  description = "Location of the user-assigned managed identity"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the user-assigned managed identity"
  default     = {}
}
