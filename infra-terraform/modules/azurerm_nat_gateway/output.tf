output "nat_gateway_ids" {
  description = "ID of the NAT gateway"
  value = {
    id                   = azurerm_nat_gateway.nat.id
    public_ip_address_id = azurerm_public_ip.pip.id
    pip_public_ip        = azurerm_public_ip.pip.public_ip_address
  }
}
