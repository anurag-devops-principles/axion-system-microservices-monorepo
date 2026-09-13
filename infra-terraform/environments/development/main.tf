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
  address_space        = ["10.10.0.0/16"]
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

module "azurerm_network_security" {
  source = "../../modules/azurerm_network_security"

  network_security_group_name = "${local.name_prefix}-nsg"
  location                    = local.region
  resource_group_name         = module.azurerm_resource_group.resource_group_ids.name
  tags                        = local.common_tags
}

module "subnet-nsg_association" {
  source = "../../modules/azurerm_subnet-nsg_association"

  subnet_id                 = module.azurerm_subnet[var.aks_subnet].subnet_ids.id
  network_security_group_id = module.azurerm_network_security.nsg_ids.id
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

module "azurerm_user_assigned_identity" {
  source = "../../modules/azurerm_managed_identity"

  uami_name           = "${local.name_prefix}-uami"
  location            = local.region
  resource_group_name = module.azurerm_resource_group.resource_group_ids.name
  tags                = local.common_tags
}

module "azurerm_container_registry" {
  source = "../../modules/azurerm_container_registry"

  container_registry_name = replace("${local.name_prefix}-acr", "-", "") # Remove hyphens for ACR name
  resource_group_name     = module.azurerm_resource_group.resource_group_ids.name
  location                = module.azurerm_resource_group.resource_group_ids.location
  sku                     = "Basic"
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
  default_node_pool_name                       = "system-pool"
  default_node_pool_node_count                 = 1
  default_node_pool_vm_size                    = "Standard_B2s"
  default_node_pool_type                       = "VirtualMachineScaleSets"
  default_node_pool_subnet_id                  = module.azurerm_subnet[var.aks_subnet].subnet_ids.id
  max_surge                                    = "33%"
  network_plugin                               = "azure"
  network_plugin_mode                          = "overlay"
  network_policy                               = "azure"
  outbound_type                                = "loadBalancer"
  pod_cidr                                     = "10.244.0.0/16"
  service_cidr                                 = "10.0.0.0/16"
  dns_service_ip                               = "10.0.0.10"
  node_provisioning_profile_default_node_pools = "Auto"
  node_provisioning_profile_mode               = "Manual"
  identity_type                                = "UserAssigned"
  user_assigned_identity_id                    = module.azurerm_user_assigned_identity.uami_ids.id
  ingress_application_gateway_id               = module.azurerm_application_gateway.appgw_ids.id
  tags                                         = local.common_tags
}

module "azurerm_role_assignment" {
  source = "../../modules/azurerm_role_assignment"

  for_each = var.role_assignment

  scope                = local.scope[each.value.scope]
  role_definition_name = each.value.role_defination_name
  principal_id         = module.azurerm_user_assigned_identity.uami_ids.principal_id
}
