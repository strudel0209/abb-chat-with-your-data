# data "namep_azure_name" "vnet" {
#   name     = "vnet"
#   location = var.location
#   type     = "azurerm_virtual_network"
# }

# resource "azurerm_virtual_network" "main" {
#   name                = data.namep_azure_name.vnet.result
#   address_space       = ["10.0.0.0/16"]
#   location            = azurerm_resource_group.main.location
#   resource_group_name = azurerm_resource_group.main.name
# }

data "namep_azure_name" "snpe" {
  name     = "pe"
  location = var.location
  type     = "azurerm_subnet"
}

resource "azurerm_subnet" "pe" {
  name                 = data.namep_azure_name.snpe.result
  resource_group_name  = azurerm_resource_group.main.name
  # virtual_network_name = azurerm_virtual_network.main.name
  virtual_network_name = var.virtual_network_name
  # address_prefixes     = ["10.0.0.0/24"]
  address_prefixes     = [cidrsubnet(var.vnet_cidr, 1, 0)]  
}

data "namep_azure_name" "snwa" {
  name     = "webapp"
  location = var.location
  type     = "azurerm_subnet"
}

resource "azurerm_subnet" "web_apps" {
  name                 = data.namep_azure_name.snwa.result
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  # address_prefixes     = ["10.0.1.0/24"]
  address_prefixes     = [cidrsubnet(var.vnet_cidr, 1, 1)]

  delegation {
    name = "delegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
