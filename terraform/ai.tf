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

  local_authentication_enabled = false
}