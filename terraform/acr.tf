data "namep_azure_name" "acr" {
  name     = "main"
  location = var.location
  type     = "azurerm_container_registry"
}

resource "azurerm_container_registry" "main" {
  name                = data.namep_azure_name.acr.result
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = false
}

resource "azurerm_role_assignment" "acrpull_admin" {
  principal_id                     = azurerm_linux_web_app.admin.identity[0].principal_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.main.id
}

resource "azurerm_role_assignment" "acrpull_fa" {
  principal_id                     = azurerm_linux_function_app.main.identity[0].principal_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.main.id
}

resource "azurerm_container_registry_task" "docker_admin" {
  name                  = "docker-admin"
  container_registry_id = azurerm_container_registry.main.id
  platform {
    os = "Linux"
  }
  docker_step {
    dockerfile_path      = "Admin.Dockerfile"
    context_path         = "https://github.com/strudel0209/abb-chat-with-your-data/tree/main/docker"
    image_names          = ["rag-adminwebapp:{{.Run.ID}}"]
    context_access_token = var.github_access_token
  }
}