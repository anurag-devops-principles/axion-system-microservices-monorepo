output "subnet_nsg_association_ids" {
  description = "ID of the subnet-NSG association"
  value       = azurerm_subnet_network_security_group_association.subnet-nsg_association.id
}
