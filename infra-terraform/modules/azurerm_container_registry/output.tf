output "container_registry" {
  description = "The created Azure Container Registry."
  value = {
    id           = azurerm_container_registry.container_registry.id
    login_server = azurerm_container_registry.container_registry.login_server
    name         = azurerm_container_registry.container_registry.name
  }
}
