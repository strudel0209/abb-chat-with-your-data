data "namep_azure_name" "di" {
  name     = "di-mvp"
  location = var.location
  type     = "azurerm_cognitive_account"
}

resource "azurerm_cognitive_account" "di" {
  name                  = data.namep_azure_name.di.result
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  kind                  = "FormRecognizer"
  custom_subdomain_name = data.namep_azure_name.di.result

  sku_name = "S0"

  identity {
    type = "SystemAssigned"
  }
}

data "namep_azure_name" "oai" {
  name     = "openai"
  location = var.location
  type     = "azurerm_cognitive_account"
}

resource "azurerm_cognitive_account" "openai" {
  name                  = data.namep_azure_name.oai.result
  location              = "swedencentral"
  resource_group_name   = azurerm_resource_group.main.name
  kind                  = "OpenAI"
  custom_subdomain_name = data.namep_azure_name.oai.result

  sku_name = "S0"

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_cognitive_deployment" "main" {
  for_each             = { for model in var.openai_embedding_models : model.name => model }
  name                 = each.key
  cognitive_account_id = azurerm_cognitive_account.openai.id
  model {
    format  = "OpenAI"
    name    = each.key
    version = each.value.version
  }

  scale {
    type     = "Standard"
    capacity = each.value.capacity
  }
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
  custom_subdomain_name = data.namep_azure_name.content_safety.result

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
  principal_id         = azurerm_linux_web_app.fe.identity[0].principal_id
}

resource "azurerm_role_assignment" "si_openai" {
  scope                = azurerm_search_service.main.id
  role_definition_name = "Search Index Data Contributor"
  principal_id         = azurerm_cognitive_account.openai.identity[0].principal_id
}

resource "azurerm_role_assignment" "si_user" {
  scope                = azurerm_search_service.main.id
  role_definition_name = "Search Index Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "search_service_contrib_openai" {
  scope                = azurerm_search_service.main.id
  role_definition_name = "Search Service Contributor"
  principal_id         = azurerm_cognitive_account.openai.identity[0].principal_id
}

resource "azurerm_role_assignment" "search_service_contrib_fa" {
  scope                = azurerm_search_service.main.id
  role_definition_name = "Search Service Contributor"
  principal_id         = azurerm_linux_function_app.main.identity[0].principal_id
}

resource "azurerm_role_assignment" "search_service_contrib_admin" {
  scope                = azurerm_search_service.main.id
  role_definition_name = "Search Service Contributor"
  principal_id         = azurerm_linux_web_app.admin.identity[0].principal_id
}

resource "azurerm_role_assignment" "cognative_services_user" {
  scope                = azurerm_resource_group.main.id
  role_definition_name = "Cognitive Services User"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "cognative_services_user_admin" {
  scope                = azurerm_resource_group.main.id
  role_definition_name = "Cognitive Services User"
  principal_id         = azurerm_linux_web_app.admin.identity[0].principal_id
}

resource "azurerm_role_assignment" "cognative_services_user_fa" {
  scope                = azurerm_resource_group.main.id
  role_definition_name = "Cognitive Services User"
  principal_id         = azurerm_linux_function_app.main.identity[0].principal_id
}

resource "azurerm_role_assignment" "cognative_services_user_webapp" {
  scope                = azurerm_resource_group.main.id
  role_definition_name = "Cognitive Services User"
  principal_id         = azurerm_linux_web_app.fe.identity[0].principal_id
}

resource "azurerm_role_assignment" "cognitive_service_contrib_fa" {
  scope                = azurerm_resource_group.main.id
  role_definition_name = "Cognitive Services Contributor"
  principal_id         = azurerm_linux_function_app.main.identity[0].principal_id
}

resource "azurerm_role_assignment" "cognitive_service_contrib_admin" {
  scope                = azurerm_resource_group.main.id
  role_definition_name = "Cognitive Services Contributor"
  principal_id         = azurerm_linux_web_app.admin.identity[0].principal_id
}

resource "azurerm_role_assignment" "cognitive_service_openai_contrib_admin" {
  scope                = azurerm_resource_group.main.id
  role_definition_name = "Cognitive Services OpenAI Contributor"
  principal_id         = azurerm_linux_web_app.admin.identity[0].principal_id
}

resource "azurerm_role_assignment" "cognitive_service_openai_contrib_fa" {
  scope                = azurerm_resource_group.main.id
  role_definition_name = "Cognitive Services OpenAI Contributor"
  principal_id         = azurerm_linux_function_app.main.identity[0].principal_id
}
