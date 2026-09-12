output "nsg_ids" {
  description = "ID of the Network Security Group"
  value = {
    id   = azurerm_network_security_group.nsg.id
    name = azurerm_network_security_group.nsg.name
  }
}
