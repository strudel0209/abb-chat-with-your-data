output "id" {
  value = azurerm_storage_account.main.id  
}

output "name" {
  value = azurerm_storage_account.main.name
}

output "primary_access_key" {
  value = azurerm_storage_account.main.primary_access_key
}

output "containers" {
  description = "Map of storage containers that are created."
  value = {
    for name, container in azapi_resource.containers :
    name => {
      id            = container.id
      name          = container.name
      public_access = container.body.properties.publicAccess
    }
  }
}

output "queues" {
  description = "Map of storage queues that are created."
  value = {
    for name, queue in azapi_resource.queues :
    name => {
      id   = queue.id
      name = queue.name
    }
  }
}