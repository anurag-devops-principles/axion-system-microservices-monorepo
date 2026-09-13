module "azurerm_resource_group" {
  source = "../../modules/azurerm_resource_group"

  resource_group_name = "${local.name_prefix}-rg"
  location            = local.region
  tags                = local.common_tags
}

module "azurerm_virtual_network" {
  source = "../../modules/azurerm_virtual_network"

  virtual_network_name = "${local.name_prefix}-vnet"
  region               = local.region
  resource_group_name  = module.azurerm_resource_group.resource_group_ids.name
  address_space        = var.vnet_address_space
  tags                 = local.common_tags
}

module "azurerm_subnet" {
  source = "../../modules/azurerm_subnet"

  for_each = var.subnets

  subnet_name          = each.value.subnet_name
  resource_group_name  = module.azurerm_resource_group.resource_group_ids.name
  address_prefixes     = each.value.address_prefixes
  virtual_network_name = module.azurerm_virtual_network.virtual_network_ids.name
}

module "azurerm_nat_gateway" {
  source = "../../modules/azurerm_nat_gateway"

  name                = "${local.name_prefix}-nat-gateway"
  location            = local.region
  resource_group_name = module.azurerm_resource_group.resource_group_ids.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.common_tags
}

module "subnet-nat-gw_association" {
  source = "../../modules/azurerm_subnet-nat-gw_association"

  subnet_id      = module.azurerm_subnet[var.aks_subnet].subnet_ids.id
  nat_gateway_id = module.azurerm_nat_gateway.nat_gateway_ids.id
}

module "azurerm_container_registry" {
  source = "../../modules/azurerm_container_registry"

  container_registry_name = replace("${local.name_prefix}-acr", "-", "") # Remove hyphens for ACR name
  resource_group_name     = module.azurerm_resource_group.resource_group_ids.name
  location                = module.azurerm_resource_group.resource_group_ids.location
  sku                     = var.acr_sku
  admin_enabled           = false
  tags                    = local.common_tags
}

module "azurerm_application_gateway" {
  source = "../../modules/azurerm_application_gateway"

  name                = "${local.name_prefix}-appgw"
  location            = local.region
  resource_group_name = module.azurerm_resource_group.resource_group_ids.name
  allocation_method   = "Static"
  sku                 = "Standard"
  sku_name            = "Standard_v2"
  sku_tier            = "Standard_v2"
  subnet_id           = module.azurerm_subnet[var.appgw_subnet].subnet_ids.id
  tags                = local.common_tags
}

module "azurerm_kubernetes_cluster" {
  source = "../../modules/azurerm_kubernetes_cluster"

  aks_cluster_name                             = "${local.name_prefix}-aks"
  resource_group_name                          = module.azurerm_resource_group.resource_group_ids.name
  location                                     = module.azurerm_resource_group.resource_group_ids.location
  dns_prefix                                   = "${local.name_prefix}-aks"
  node_resource_group_name                     = "${local.name_prefix}-aks-MC"
  default_node_pool_name                       = "systempool"
  default_node_pool_node_count                 = var.aks_node_count
  default_node_pool_vm_size                    = var.aks_vm_size
  default_node_pool_type                       = "VirtualMachineScaleSets"
  default_node_pool_subnet_id                  = module.azurerm_subnet[var.aks_subnet].subnet_ids.id
  max_surge                                    = "33%"
  network_plugin                               = "azure"
  network_plugin_mode                          = "overlay"
  network_policy                               = "azure"
  outbound_type                                = "userAssignedNATGateway"
  pod_cidr                                     = var.pod_cidr
  service_cidr                                 = var.service_cidr
  dns_service_ip                               = var.dns_service_ip
  node_provisioning_profile_default_node_pools = "Auto"
  node_provisioning_profile_mode               = "Manual"
  identity_type                                = "SystemAssigned"
  ingress_application_gateway_id               = module.azurerm_application_gateway.appgw_ids.id
  tags                                         = local.common_tags

  depends_on = [module.subnet-nat-gw_association]
}

# AKS kubelet identity needs AcrPull to pull images from the container registry
module "aks_acr_pull" {
  source = "../../modules/azurerm_role_assignment"

  scope                = module.azurerm_container_registry.container_registry_ids.id
  role_definition_name = "AcrPull"
  principal_id         = module.azurerm_kubernetes_cluster.kubernetes_cluster_ids.kubelet_object_id
}

# AGIC identity requires Contributor on the App Gateway to manage routing rules
module "agic_appgw_contributor" {
  source = "../../modules/azurerm_role_assignment"

  scope                = module.azurerm_application_gateway.appgw_ids.id
  role_definition_name = "Contributor"
  principal_id         = module.azurerm_kubernetes_cluster.kubernetes_cluster_ids.agic_identity_object_id
}

# AGIC identity requires Reader on the Resource Group to list and discover resources
module "agic_rg_reader" {
  source = "../../modules/azurerm_role_assignment"

  scope                = module.azurerm_resource_group.resource_group_ids.id
  role_definition_name = "Reader"
  principal_id         = module.azurerm_kubernetes_cluster.kubernetes_cluster_ids.agic_identity_object_id
}
