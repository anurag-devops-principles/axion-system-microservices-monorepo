variable "scope" {
  description = "The scope at which the role assignment applies. This can be a subscription, resource group, or specific resource."
  type        = string
}

variable "role_definition_name" {
  description = "The name of the role definition to assign (e.g., 'Contributor', 'Reader')."
  type        = string
}

variable "principal_id" {
  description = "The object ID of the principal (user, group, or service principal) to which the role will be assigned."
  type        = string
}
