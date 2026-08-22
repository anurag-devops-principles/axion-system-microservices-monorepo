module "azurerm_resource_group" {
  source = "../../modules/azurerm_resource_group"

  resource_group_name = "${local.name_prefix}-rg"
  location            = local.region
  tags                = local.common_tags
}

module "azurerm_container_registry" {
  source = "../../modules/azurerm_container_registry"

  container_registry_name = replace("${local.name_prefix}-acr", "-", "") # Remove hyphens for ACR name
  resource_group_name     = module.azurerm_resource_group.resource_group_ids.name
  location                = module.azurerm_resource_group.resource_group_ids.location
  sku                     = "Standard"
  admin_enabled           = false
  tags                    = local.common_tags
}

module "azurerm_kubernetes_cluster" {
  source = "../../modules/azurerm_kubernetes_cluster"

  aks_cluster_name             = "${local.name_prefix}-aks"
  resource_group_name          = module.azurerm_resource_group.resource_group_ids.name
  location                     = module.azurerm_resource_group.resource_group_ids.location
  dns_prefix                   = "${local.name_prefix}-aks"
  node_resource_group_name     = "${local.name_prefix}-aks-resources"
  default_node_pool_name       = "default"
  default_node_pool_node_count = 1
  default_node_pool_vm_size    = "Standard_B2s"
  default_node_pool_type       = "VirtualMachineScaleSets"
  identity_type                = "SystemAssigned"
  tags                         = local.common_tags
}

module "azurerm_role_assignment" {
  source = "../../modules/azurerm_role_assignment"

  scope                = module.azurerm_container_registry.container_registry.id
  role_definition_name = "ACRPull"
  principal_id         = module.azurerm_kubernetes_cluster.kubernetes_cluster.kubelet_object_id
}
