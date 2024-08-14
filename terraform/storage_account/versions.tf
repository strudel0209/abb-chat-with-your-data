terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.111"
    }
    azapi = {
      source  = "Azure/azapi"
      version = ">= 1.9.0, < 2.0.0"
    }
    namep = {
      source  = "jason-johnson/namep"
      version = "~> 1.1"
    }
  }
}