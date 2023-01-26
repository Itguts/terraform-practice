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
locals {  
  tags = {
    environment = "Staging"
    owner = "itguts"
  }
}


resource "azurerm_resource_group" "rg" {
  name      = var.rsgname
  location  = var.location
  tags = local.tags
}
resource "azurerm_storage_account" "stgacc" {
  name                     = var.stgname
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

#   tags = {
#     environment = "staging"
#   }
tags = local.tags
}