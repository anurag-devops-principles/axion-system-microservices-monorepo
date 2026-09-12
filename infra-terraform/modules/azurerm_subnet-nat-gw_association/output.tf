output "subnet_nat_gw_association_ids" {
  description = "ID of the subnet-NAT gateway association"
  value       = azurerm_subnet_nat_gateway_association.subnet-nat-gw_association.id
}
