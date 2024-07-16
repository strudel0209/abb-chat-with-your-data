locals {
  rbac_policy_map = {
    key_permissions = {
      manage     = "Key Vault Crypto Officer"
      read       = "Key Vault Crypto User"
      contribute = "Key Vault Crypto User"
    }
    secret_permissions = {
      manage     = "Key Vault Secrets Officer"
      read       = "Key Vault Secrets User"
      contribute = "Key Vault Secrets Officer"
    }
    certificate_permissions = {
      manage     = "Key Vault Certificates Officer"
      read       = "Key Vault Certificates Officer"
      contribute = "Key Vault Certificates Officer"
    }
  }

  common_app_settings = {
    "AZURE_AUTH_TYPE"                = "rbac"
    "AZURE_BLOB_ACCOUNT_NAME"        = azurerm_storage_account.main.name
    "AZURE_BLOB_CONTAINER_NAME"      = azurerm_storage_container.documents.name
    "AZURE_CONTENT_SAFETY_ENDPOINT"  = azurerm_cognitive_account.content_safety.endpoint
    "AZURE_FORM_RECOGNIZER_ENDPOINT" = azurerm_cognitive_account.di.endpoint
    "AZURE_OPENAI_MODEL"             = "gpt-4"
    "AZURE_OPENAI_EMBEDDING_MODEL"   = "text-embedding-ada-002"
#    "AZURE_OPENAI_RESOURCE"          = azurerm_cognitive_account.openai.name      # I think this is the wrong thing to use for our use case
    "AZURE_OPENAI_ENDPOINT"          = azurerm_cognitive_account.openai.endpoint
    "AZURE_OPENAI_API_VERSION"       = "2024-02-01"
    "AZURE_SEARCH_SERVICE"           = "https://${azurerm_search_service.main.name}.search.windows.net"
    "AZURE_SEARCH_INDEX"             = "index-${random_id.storage_account.hex}"
    "ORCHESTRATION_STRATEGY"         = "openai_function"
    "LOGLEVEL"                       = "INFO"
    #    "WEBSITE_DNS_SERVER"                   = "NOT USED YET"
  }

  app_insights_app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"                  = azurerm_application_insights.main.instrumentation_key
    "APPINSIGHTS_PROFILERFEATURE_VERSION"             = "1.0.0"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"             = "1.0.0"
    "APPLICATIONINSIGHTS_CONNECTION_STRING"           = azurerm_application_insights.main.connection_string
    "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT"       = null
    "ApplicationInsightsAgent_EXTENSION_VERSION"      = "~3"
    "DiagnosticServices_EXTENSION_VERSION"            = "~3"
    "InstrumentationEngine_EXTENSION_VERSION"         = "disabled"
    "SnapshotDebugger_EXTENSION_VERSION"              = "disabled"
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    "XDT_MicrosoftApplicationInsights_Mode"           = "recommended"
    "XDT_MicrosoftApplicationInsights_PreemptSdk"     = "disabled"
  }

  web_app_extra_settings = {
    "AZURE_OPENAI_MODEL_NAME"              = "gpt-4"
    "AZURE_OPENAI_TEMPERATURE"             = "0"
    "AZURE_OPENAI_TOP_P"                   = "1"
    "AZURE_OPENAI_MAX_TOKENS"              = "1000"
    "AZURE_OPENAI_STOP_SEQUENCE"           = ""
    "AZURE_OPENAI_SYSTEM_MESSAGE"          = "You are an AI assistant that helps people find information."
    "AZURE_OPENAI_STREAM"                  = "true"
    "AZURE_SEARCH_USE_SEMANTIC_SEARCH"     = "false"
    "AZURE_SEARCH_CONVERSATIONS_LOG_INDEX" = "conversations"
    "AZURE_SEARCH_SEMANTIC_SEARCH_CONFIG"  = "default"
    "AZURE_SEARCH_INDEX_IS_PRECHUNKED"     = "false"
    "AZURE_SEARCH_TOP_K"                   = "5"
    "AZURE_SEARCH_ENABLE_IN_DOMAIN"        = "false"
    "AZURE_SEARCH_CONTENT_COLUMNS"         = "content"
    "AZURE_SEARCH_FILENAME_COLUMN"         = "filename"
    "AZURE_SEARCH_FILTER"                  = ""
    "AZURE_SEARCH_TITLE_COLUMN"            = "title"
    "AZURE_SEARCH_URL_COLUMN"              = "url"
    #    "AZURE_SPEECH_SERVICE_NAME"            = "NOT USED"
    #    "AZURE_SPEECH_SERVICE_REGION"          = "NOT USED"
    #    "SPEECH_RECOGNIZER_LANGUAGES"          = "NOT USED"
  }

  admin_app_settings = {
    "BACKEND_URL" = "https://${azurerm_linux_function_app.main.default_hostname}"
    "FUNCTION_KEY" = data.azurerm_function_app_host_keys.main.primary_key
  }

  app_insights_tags = {
    "hidden-link: /app-insights-conn-string"         = azurerm_application_insights.main.connection_string
    "hidden-link: /app-insights-instrumentation-key" = azurerm_application_insights.main.instrumentation_key
    "hidden-link: /app-insights-resource-id"         = azurerm_application_insights.main.id
  }

  function_app_settings = {
    "DOCUMENT_PROCESSING_QUEUE_NAME" = azurerm_storage_queue.main.name
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }
}
