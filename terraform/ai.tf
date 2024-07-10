data "namep_azure_name" "di" {
  name     = "di-mvp"
  location = var.location
  type     = "azurerm_cognitive_account"
}

resource "azurerm_cognitive_account" "di" {
  name                = data.namep_azure_name.di.result
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  kind                = "FormRecognizer"

  sku_name = "S0"
}

data "namep_azure_name" "oai" {
  name     = "openai"
  location = var.location
  type     = "azurerm_cognitive_account"
}

resource "azurerm_cognitive_account" "openai" {
  name                = data.namep_azure_name.oai.result
  location            = "swedencentral"
  resource_group_name = azurerm_resource_group.main.name
  kind                = "OpenAI"

  sku_name = "S0"
}

data "namep_azure_name" "content_safety" {
  name     = "safe"
  location = var.location
  type     = "azurerm_cognitive_account"
}

resource "azurerm_cognitive_account" "content_safety" {
  name                = data.namep_azure_name.content_safety.result
  location            = "swedencentral"
  resource_group_name = azurerm_resource_group.main.name
  kind                = "ContentSafety"

  sku_name = "S0"
}

data "namep_azure_name" "search" {
  name     = "mvp"
  location = var.location
  type     = "azurerm_search_service"
}

resource "azurerm_search_service" "main" {
  name                = data.namep_azure_name.search.result
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "standard"

  identity {
    type = "SystemAssigned"
  }

  local_authentication_enabled = false
}

resource "azurerm_role_assignment" "si_admin" {
  scope                = azurerm_search_service.main.id
  role_definition_name = "Search Index Data Contributor"
  principal_id         = azurerm_linux_web_app.admin.identity[0].principal_id
}

resource "azurerm_role_assignment" "si_fa" {
  scope                = azurerm_search_service.main.id
  role_definition_name = "Search Index Data Contributor"
  principal_id         = azurerm_linux_function_app.main.identity[0].principal_id
}

resource "azurerm_role_assignment" "si_webapp" {
  scope                = azurerm_search_service.main.id
  role_definition_name = "Search Index Data Contributor"
  principal_id         = azurerm_linux_web_app.docker.identity[0].principal_id
}

resource "azurerm_role_assignment" "si_user" {
  scope                = azurerm_search_service.main.id
  role_definition_name = "Search Index Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}