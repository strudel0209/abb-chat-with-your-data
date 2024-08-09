resource "random_id" "storage_account" {
  byte_length = 4
}

data "namep_azure_name" "sa" {
  name     = "mvp"
  location = var.location
  type     = "azurerm_storage_account"

  extra_tokens = {
    rnd = lower(random_id.storage_account.hex)
  }
}

resource "azurerm_storage_account" "main" {
  name                            = data.namep_azure_name.sa.result
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  public_network_access_enabled   = false
  allow_nested_items_to_be_public = false
}

resource "azurerm_storage_container" "documents" {
  name                  = "documents"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "config" {
  name                  = "config"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

resource "azurerm_storage_queue" "main" {
  name                 = "doc-processing"
  storage_account_name = azurerm_storage_account.main.name
}

# roles

resource "azurerm_role_assignment" "sa_admin_blob_contrib" {
  scope                = azurerm_storage_account.main.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_linux_web_app.admin.identity[0].principal_id
}

resource "azurerm_role_assignment" "sa_fa_blob_contrib" {
  scope                = azurerm_storage_account.main.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_linux_function_app.main.identity[0].principal_id
}

resource "azurerm_role_assignment" "sa_fa_queue_contrib" {
  scope                = azurerm_storage_account.main.id
  role_definition_name = "Storage Queue Data Contributor"
  principal_id         = azurerm_linux_function_app.main.identity[0].principal_id
}

resource "azurerm_role_assignment" "sa_web_fe_read" {
  scope                = azurerm_storage_account.main.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_linux_web_app.fe.identity[0].principal_id
}

resource "azurerm_role_assignment" "sa_form_recognizer_read" {
  scope                = azurerm_storage_account.main.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_cognitive_account.di.identity[0].principal_id
}

# private endpoints

module "sa_blob" {
  source = "./private-endpoint"

  name                = "sa-blob"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  # vnet_id             = azurerm_virtual_network.main.id
  vnet_id             = data.azurerm_virtual_network.example.id
  subnet_id           = azurerm_subnet.pe.id
  service_type        = "blob"
  resources           = [{ name = "sa-blob", id = azurerm_storage_account.main.id }]
}

module "sa_queue" {
  source = "./private-endpoint"

  name                = "sa-queue"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  # vnet_id             = azurerm_virtual_network.main.id
  vnet_id             = data.azurerm_virtual_network.example.id
  subnet_id           = azurerm_subnet.pe.id
  service_type        = "queue"
  resources           = [{ name = "sa-queue", id = azurerm_storage_account.main.id }]
}
