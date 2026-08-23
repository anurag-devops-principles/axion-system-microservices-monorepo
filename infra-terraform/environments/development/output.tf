output "resource_group_id" {
  value = module.azurerm_resource_group.resource_group
}

output "container_registry" {
  value = module.azurerm_container_registry.container_registry
}

output "kubernetes_cluster" {
  value = module.azurerm_kubernetes_cluster.kubernetes_cluster
}

output "role_assignment_id" {
  value = module.azurerm_role_assignment.role_assignment
}
