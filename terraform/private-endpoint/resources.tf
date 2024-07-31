
resource "azurerm_private_dns_zone" "main" {
  name                = local.zone_map[var.service_type].zone
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "main" {
  name                  = "${var.name}-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.main.name
  virtual_network_id    = var.vnet_id
}

resource "azurerm_private_endpoint" "main" {
  for_each            = { for resource in var.resources : resource.name => resource }
  name                = "${each.key}-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${each.key}-privateserviceconnection"
    private_connection_resource_id = each.value.id
    subresource_names              = [local.zone_map[var.service_type].name]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "${each.key}-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.main.id]
  }
}
