output "virtual_network_ids" {
  value = {
    id                  = azurerm_virtual_network.virtual_network.id
    name                = azurerm_virtual_network.virtual_network.name
    location            = azurerm_virtual_network.virtual_network.location
    resource_group_name = azurerm_virtual_network.virtual_network.resource_group_name
    address_space       = azurerm_virtual_network.virtual_network.address_space
  }
}
