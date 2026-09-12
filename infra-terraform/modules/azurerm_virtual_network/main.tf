resource "azurerm_virtual_network" "virtual_network" {
  name                = var.virtual_network_name
  location            = var.region
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  tags                = var.tags
}
