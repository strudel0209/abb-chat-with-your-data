module "keyvault" {
  source = "github.com/jason-johnson/tf-azure-keyvault?ref=v1.1.3"

  name                = "mvp"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  use_rbac            = true
  managing_object_id  = data.azurerm_client_config.current.object_id
  permissions = [
    {
      name                    = azurerm_linux_function_app.main.name
      object_id               = azurerm_linux_function_app.main.identity[0].principal_id
      key_permissions         = "read"
      secret_permissions      = "read"
      certificate_permissions = "read"
    },
    {
      name                    = azurerm_linux_web_app.admin.name
      object_id               = azurerm_linux_web_app.admin.identity[0].principal_id
      key_permissions         = "read"
      secret_permissions      = "read"
      certificate_permissions = "read"
    },
    {
      name                    = azurerm_linux_web_app.fe.name
      object_id               = azurerm_linux_web_app.fe.identity[0].principal_id
      key_permissions         = "read"
      secret_permissions      = "read"
      certificate_permissions = "read"
    }
  ]

  secrets = var.secrets
}
