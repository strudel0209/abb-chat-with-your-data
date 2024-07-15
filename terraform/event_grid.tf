resource "azurerm_eventgrid_system_topic" "main" {
  name                   = "doc-processing"
  resource_group_name    = azurerm_resource_group.main.name
  location               = azurerm_resource_group.main.location
  source_arm_resource_id = azurerm_storage_account.main.id
  topic_type             = "Microsoft.Storage.StorageAccounts"
}

resource "azurerm_eventgrid_system_topic_event_subscription" "main" {
  name                = "BlobEvents"
  system_topic        = azurerm_eventgrid_system_topic.main.name
  resource_group_name = azurerm_resource_group.main.name

  included_event_types                 = ["Microsoft.Storage.BlobCreated", "Microsoft.Storage.BlobDeleted"]
  advanced_filtering_on_arrays_enabled = true

  storage_queue_endpoint {
    storage_account_id                    = azurerm_storage_account.main.id
    queue_name                            = azurerm_storage_queue.main.name
    queue_message_time_to_live_in_seconds = -1
  }

  subject_filter {
    subject_begins_with = "/blobServices/default/containers/${azurerm_storage_container.documents.name}/blobs/"
  }

  retry_policy {
    max_delivery_attempts = 5
    event_time_to_live    = 1440
  }
}
