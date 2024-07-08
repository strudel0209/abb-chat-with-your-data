data "namep_azure_name" "rg" {
  name     = "mvp"
  location = var.location
  type     = "azurerm_resource_group"
}

resource "azurerm_resource_group" "main" {
  name     = data.namep_azure_name.rg.result
  location = var.location
}

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
  allow_nested_items_to_be_public = false
}

data "namep_azure_name" "law" {
  name     = "mvp"
  location = var.location
  type     = "azurerm_log_analytics_workspace"
}

resource "azurerm_log_analytics_workspace" "main" {
  name                = data.namep_azure_name.law.result
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

data "namep_azure_name" "ai" {
  name     = "mvp"
  location = var.location
  type     = "azurerm_application_insights"
}

resource "azurerm_application_insights" "main" {
  name                = data.namep_azure_name.ai.result
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  workspace_id        = azurerm_log_analytics_workspace.main.id
  application_type    = "web"
}