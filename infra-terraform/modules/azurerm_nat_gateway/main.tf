resource "azurerm_public_ip" "pip" {
  name                = "${var.name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  sku                 = var.sku

  tags = var.tags
}

resource "azurerm_nat_gateway" "nat" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "pip-association" {
  nat_gateway_id       = azurerm_nat_gateway.nat.id
  public_ip_address_id = azurerm_public_ip.pip.id
}

resource "azurerm_subnet_nat_gateway_association" "subnet_association" {
  count = var.subnet_id != null ? 1 : 0

  subnet_id      = var.subnet_id
  nat_gateway_id = azurerm_nat_gateway.nat.id
}
