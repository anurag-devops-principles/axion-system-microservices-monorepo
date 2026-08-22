resource "azurerm_kubernetes_cluster" "example" {
  name                = var.aks_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = var.default_node_pool_name
    node_count = var.default_node_pool_node_count
    vm_size    = var.default_node_pool_vm_size
    type       = var.default_node_pool_type
  }

  identity {
    type = var.identity_type
  }
  tags = var.tags
}
