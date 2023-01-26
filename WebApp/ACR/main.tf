terraform {

  required_version = ">=0.12"
  
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}
}
# Create a Resource Group
resource "azurerm_resource_group" "acr-rg" {
  name = var.rsgname
  location = var.location  
}
 
# Azure Container Regristry
resource "azurerm_container_registry" "acr" {
  name                     = var.container_registry_name
  resource_group_name      = azurerm_resource_group.acr-rg.name
  location                 = azurerm_resource_group.acr-rg.location
  sku                      = "Standard"
  admin_enabled            = true
}