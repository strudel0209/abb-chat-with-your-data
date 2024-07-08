data "namep_azure_name" "asp" {
  name     = "mvp"
  location = var.location
  type     = "azurerm_app_service_plan"
}

resource "azurerm_service_plan" "main" {
  name                = data.namep_azure_name.asp.result
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

data "namep_azure_name" "fa" {
  name     = "mvp"
  location = var.location
  type     = "azurerm_function_app"
}

resource "azurerm_linux_function_app" "main" {
  name                = data.namep_azure_name.fa.result
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  storage_account_name       = azurerm_storage_account.main.name
  storage_account_access_key = azurerm_storage_account.main.primary_access_key
  service_plan_id            = azurerm_service_plan.main.id

  site_config {}
}

data "namep_azure_name" "wa_admin" {
  name     = "admin"
  location = var.location
  type     = "azurerm_app_service"
}

resource "azurerm_linux_web_app" "admin" {
  name                = data.namep_azure_name.wa_admin.result
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_service_plan.main.location
  service_plan_id     = azurerm_service_plan.main.id

  site_config {}
}

data "namep_azure_name" "wa_docker" {
  name     = "docker"
  location = var.location
  type     = "azurerm_app_service"
}

resource "azurerm_linux_web_app" "docker" {
  name                = data.namep_azure_name.wa_docker.result
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_service_plan.main.location
  service_plan_id     = azurerm_service_plan.main.id

  site_config {}
}