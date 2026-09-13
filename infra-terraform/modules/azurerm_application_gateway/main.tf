resource "azurerm_public_ip" "pip" {
  name                = "${var.name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  sku                 = var.sku

  tags = var.tags
}

resource "azurerm_application_gateway" "appgw" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "${var.name}-ipcfg"
    subnet_id = var.subnet_id
  }

  frontend_ip_configuration {
    name                 = "${var.name}-feip"
    public_ip_address_id = azurerm_public_ip.pip.id
  }

  frontend_port {
    name = "${var.name}-feport"
    port = 80
  }

  backend_address_pool {
    name = "${var.name}-beap"
  }

  backend_http_settings {
    name                  = "${var.name}-be-htst"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "${var.name}-httplstn"
    frontend_ip_configuration_name = "${var.name}-feip"
    frontend_port_name             = "${var.name}-feport"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${var.name}-rqrt"
    rule_type                  = "Basic"
    priority                   = 100
    http_listener_name         = "${var.name}-httplstn"
    backend_address_pool_name  = "${var.name}-beap"
    backend_http_settings_name = "${var.name}-be-htst"
  }
  tags = var.tags
}
