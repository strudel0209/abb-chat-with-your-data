data "namep_azure_name" "rg" {
  name     = "mvp"
  location = var.location
  type     = "azurerm_resource_group"
}

resource "azurerm_resource_group" "main" {
  name     = data.namep_azure_name.rg.result
  location = var.location
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