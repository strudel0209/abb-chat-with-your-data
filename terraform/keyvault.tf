data "namep_azure_name" "kv" {
  name     = "mvp"
  location = var.location
  type     = "azurerm_key_vault"
}

resource "azurerm_key_vault" "main" {
  name                        = data.namep_azure_name.kv.result
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  enable_rbac_authorization   = true

  sku_name = "standard"
}

resource "azurerm_role_assignment" "manager" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "manager_roles" {
  for_each = toset(["key_permissions", "secret_permissions", "certificate_permissions"])

  scope                = azurerm_key_vault.main.id
  role_definition_name = local.rbac_policy_map[each.key].manage
  principal_id         = data.azurerm_client_config.current.object_id
}

/* resource "azurerm_role_assignment" "roles" {
  for_each             = { for e in local.rbac_policy_permissions : "${e.object_id}-${e.permission}" => e }
  scope                = azurerm_key_vault.main.id
  role_definition_name = each.value.permission
  principal_id         = each.value.object_id
} */

resource "azurerm_key_vault_secret" "main" {
  for_each     = {for secret in var.secrets : secret.name => secret}
  name         = each.value.name
  value        = each.value.value
  key_vault_id = azurerm_key_vault.main.id

  depends_on = [azurerm_role_assignment.manager, azurerm_role_assignment.manager_roles["secret_permissions"]]
}
