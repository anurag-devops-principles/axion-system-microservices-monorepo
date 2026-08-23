output "role_assignment" {
  value = {
    id                   = azurerm_role_assignment.role_assignment.id
    scope                = azurerm_role_assignment.role_assignment.scope
    role_definition_name = azurerm_role_assignment.role_assignment.role_definition_name
    principal_id         = azurerm_role_assignment.role_assignment.principal_id
  }
}
