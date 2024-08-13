data "namep_azure_name" "vnet" {
  name     = "vnet"
  location = var.location
  type     = "azurerm_virtual_network"
}

resource "azurerm_virtual_network" "main" {
  count               = length(var.vnet_name) > 0 ? 0 : 1
  name                = data.namep_azure_name.vnet.result
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

data "azurerm_virtual_network" "main" {
  count               = length(var.vnet_name) > 0 ? 1 : 0
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.main.name
}

data "namep_azure_name" "snpe" {
  name     = "pe"
  location = var.location
  type     = "azurerm_subnet"
}

resource "azurerm_subnet" "pe" {
  name                 = data.namep_azure_name.snpe.result
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = local.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

data "namep_azure_name" "snwa" {
  name     = "webapp"
  location = var.location
  type     = "azurerm_subnet"
}

resource "azurerm_subnet" "web_apps" {
  name                 = data.namep_azure_name.snwa.result
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = local.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  delegation {
    name = "delegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
