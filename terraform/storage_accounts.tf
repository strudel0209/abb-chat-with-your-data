resource "random_id" "storage_account" {
  byte_length = 4
}

module "storage_account" {
  source = "./storage_account"

  name                          = "mvp"
  resource_group_name           = azurerm_resource_group.main.name
  location                      = azurerm_resource_group.main.location
  random_seed                   = random_id.storage_account.hex
  public_network_access_enabled = var.storage_account_public_access_enabled

  containers = [
    { name = "documents"},
    { name = "config"}
    ]

  queues = [
    { name = "doc-processing"}
  ]
}

# roles

resource "azurerm_role_assignment" "sa_admin_blob_contrib" {
  scope                = module.storage_account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_linux_web_app.admin.identity[0].principal_id
}

resource "azurerm_role_assignment" "sa_fa_blob_contrib" {
  scope                = module.storage_account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_linux_function_app.main.identity[0].principal_id
}

resource "azurerm_role_assignment" "sa_fa_queue_contrib" {
  scope                = module.storage_account.id
  role_definition_name = "Storage Queue Data Contributor"
  principal_id         = azurerm_linux_function_app.main.identity[0].principal_id
}

resource "azurerm_role_assignment" "sa_web_fe_read" {
  scope                = module.storage_account.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_linux_web_app.fe.identity[0].principal_id
}

resource "azurerm_role_assignment" "sa_form_recognizer_read" {
  scope                = module.storage_account.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_cognitive_account.di.identity[0].principal_id
}

# private endpoints

module "sa_blob" {
  source = "./private-endpoint"

  name                = "sa-blob"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vnet_id             = local.vnet.id
  subnet_id           = azurerm_subnet.pe.id
  service_type        = "blob"
  resources           = [{ name = "sa-blob", id = module.storage_account.id }]
}

module "sa_queue" {
  source = "./private-endpoint"

  name                = "sa-queue"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vnet_id             = local.vnet.id
  subnet_id           = azurerm_subnet.pe.id
  service_type        = "queue"
  resources           = [{ name = "sa-queue", id = module.storage_account.id }]
}
