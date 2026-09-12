variable "aks_cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "location" {
  description = "The Azure region where the AKS cluster will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the AKS cluster."
  type        = string
}

variable "dns_prefix" {
  description = "The DNS prefix to use with the AKS cluster."
  type        = string
}

variable "node_resource_group_name" {
  description = "The name of the resource group to create the node resources in."
  type        = string
  default     = null
}

variable "default_node_pool_name" {
  description = "The name of the default node pool."
  type        = string
}

variable "default_node_pool_node_count" {
  description = "The number of nodes in the default node pool."
  type        = number
}

variable "default_node_pool_vm_size" {
  description = "The size of the virtual machines in the default node pool."
  type        = string
}

variable "default_node_pool_type" {
  description = "The type of the default node pool (e.g., VirtualMachineScaleSets)."
  type        = string
}

variable "max_surge" {
  description = "The maximum number of nodes to add during an upgrade."
  type        = string
  default     = "10%"
}

variable "default_node_pool_subnet_id" {
  description = "The ID of the subnet to place the default node pool nodes in."
  type        = string
}

variable "ingress_application_gateway_id" {
  description = "The resource ID of an existing Application Gateway to use as the ingress controller (AGIC)."
  type        = string
}

variable "node_provisioning_profile_default_node_pools" {
  description = "The default node pools for the node provisioning profile."
  type        = string
  default     = "Auto"
}

variable "node_provisioning_profile_mode" {
  description = "The mode of the node provisioning profile."
  type        = string
  default     = "Manual"
}

variable "identity_type" {
  description = "The type of identity used for the AKS cluster (e.g., SystemAssigned, UserAssigned, None)."
  type        = string
}

variable "user_assigned_identity_id" {
  description = "The resource ID of the user-assigned identity to use for the AKS cluster."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the AKS cluster."
  type        = map(string)
  default     = {}
}
