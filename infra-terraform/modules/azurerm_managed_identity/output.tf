output "uami_ids" {
  description = "The ID of the user-assigned managed identity"
  value = {
    id           = azurerm_user_assigned_identity.uami.id
    name         = azurerm_user_assigned_identity.uami.name
    principal_id = azurerm_user_assigned_identity.uami.principal_id
  }
}
