resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.aks_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  node_resource_group = var.node_resource_group_name

  default_node_pool {
    name           = var.default_node_pool_name
    node_count     = var.default_node_pool_node_count
    vm_size        = var.default_node_pool_vm_size
    type           = var.default_node_pool_type
    vnet_subnet_id = var.default_node_pool_subnet_id

    upgrade_settings {
      max_surge = var.max_surge
    }
  }

  node_provisioning_profile {
    default_node_pools = var.node_provisioning_profile_default_node_pools
    mode               = var.node_provisioning_profile_mode
  }

  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" ? [var.user_assigned_identity_id] : null
  }

  ingress_application_gateway {
    gateway_id = var.ingress_application_gateway_id
  }

  tags = var.tags
}
