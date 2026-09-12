output "appgw_ids" {
  description = "Key outputs from the Application Gateway resource"
  value = {
    id   = azurerm_application_gateway.appgw.id
    name = azurerm_application_gateway.appgw.name
  }
}
