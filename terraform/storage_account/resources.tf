data "namep_azure_name" "sa" {
  name     = var.name
  location = var.location
  type     = "azurerm_storage_account"

  extra_tokens = {
    rnd = lower(var.random_seed)
  }
}

resource "azurerm_storage_account" "main" {
  name                            = data.namep_azure_name.sa.result
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  public_network_access_enabled   = var.public_network_access_enabled
  allow_nested_items_to_be_public = false
}

# This uses azapi in order to avoid having to grant data plane permissions or worry about public access enabled
resource "azapi_resource" "containers" {
  for_each = { for c in  var.containers : c.name => c }

  type = "Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01"
  body = {
    properties = {
      publicAccess                   = each.value.public_access
    }
  }
  name                      = each.value.name
  parent_id                 = "${azurerm_storage_account.main.id}/blobServices/default"
  schema_validation_enabled = false #https://github.com/Azure/terraform-provider-azapi/issues/497
}

resource "azapi_resource" "queues" {
  for_each = { for q in  var.queues : q.name => q }

  type = "Microsoft.Storage/storageAccounts/queueServices/queues@2023-01-01"
  body = {
    properties = {
      metadata = {}
    }
  }
  name                      = each.value.name
  parent_id                 = "${azurerm_storage_account.main.id}/queueServices/default"
  schema_validation_enabled = false
}