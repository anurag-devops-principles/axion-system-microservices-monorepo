output "resource_group_ids" {
  description = "Resource group ID, name, and location"
  value       = module.azurerm_resource_group.resource_group_ids
}

output "virtual_network_ids" {
  description = "Virtual network ID, name, location, and address space"
  value       = module.azurerm_virtual_network.virtual_network_ids
}

output "subnet_ids" {
  description = "Map of subnet IDs, names, and address prefixes keyed by subnet key"
  value       = { for k, v in module.azurerm_subnet : k => v.subnet_ids }
}

output "nat_gateway_ids" {
  description = "NAT gateway ID and public IP address"
  value       = module.azurerm_nat_gateway.nat_gateway_ids
}

output "container_registry_ids" {
  description = "Container registry ID, login server, and name"
  value       = module.azurerm_container_registry.container_registry_ids
}

output "appgw_ids" {
  description = "Application gateway ID and name"
  value       = module.azurerm_application_gateway.appgw_ids
}

output "kubernetes_cluster_ids" {
  description = "AKS cluster ID, name, kubelet identity, OIDC issuer URL, and AGIC identity"
  sensitive   = true
  value       = module.azurerm_kubernetes_cluster.kubernetes_cluster_ids
}
