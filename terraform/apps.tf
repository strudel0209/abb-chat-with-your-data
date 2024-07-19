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

  ftp_publish_basic_authentication_enabled       = false
  webdeploy_publish_basic_authentication_enabled = false

  site_config {
    application_stack {
      docker {
        registry_url = "https://fruoccopublic.azurecr.io"
        image_name   = "rag-backend"
        image_tag    = "latest"
      }
    }
    application_insights_connection_string = azurerm_application_insights.main.connection_string
    application_insights_key               = azurerm_application_insights.main.instrumentation_key
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = merge(local.common_app_settings, local.function_app_settings)

  tags = local.app_insights_tags
}

data "azurerm_function_app_host_keys" "main" {
  name                = azurerm_linux_function_app.main.name
  resource_group_name = azurerm_resource_group.main.name
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

  ftp_publish_basic_authentication_enabled       = false
  webdeploy_publish_basic_authentication_enabled = false

  site_config {
    application_stack {
      docker_image_name   = "rag-adminwebapp:latest"
      docker_registry_url = "https://fruoccopublic.azurecr.io"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = merge(local.common_app_settings, local.app_insights_app_settings, local.web_app_extra_settings, local.admin_app_settings, local.function_app_settings)

  tags = local.app_insights_tags
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

  ftp_publish_basic_authentication_enabled       = false
  webdeploy_publish_basic_authentication_enabled = false

  site_config {
    application_stack {
      docker_image_name   = "alexsachelarescu/abb-ai-chat:20240605.5"
      docker_registry_url = "https://index.docker.io"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = merge(local.common_app_settings, local.app_insights_app_settings, local.web_app_extra_settings)

  tags = local.app_insights_tags
}
