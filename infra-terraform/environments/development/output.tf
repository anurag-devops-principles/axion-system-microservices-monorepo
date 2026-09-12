output "resource_group_id" {
  value = module.azurerm_resource_group.resource_group_ids
}

output "virtual_network_ids" {
  value = module.azurerm_virtual_network.virtual_network_ids
}

output "subnet_ids" {
  value = { for k, v in module.azurerm_subnet : k => v.subnet_ids }
}

output "network_security_group_ids" {
  value = module.azurerm_network_security.nsg_ids
}

output "subnet_nsg_association_ids" {
  value = module.subnet-nsg_association.subnet_nsg_association_ids
}

output "nat_gateway_ids" {
  value = module.azurerm_nat_gateway.nat_gateway_ids
}

output "subnet_nat_gw_association_ids" {
  value = module.subnet-nat-gw_association.subnet_nat_gw_association_ids
}

# output "container_registry" {
#   value = module.azurerm_container_registry.container_registry
# }

# output "kubernetes_cluster" {
#   value = module.azurerm_kubernetes_cluster.kubernetes_cluster
# }

# output "role_assignment_id" {
#   value = module.azurerm_role_assignment.role_assignment
# }
