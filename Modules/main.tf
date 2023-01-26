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

module "ResourceGroup" {
  source = "./ResourceGroup"
  base_name = "itguts"
  location = "WestUs"
}
module "StorageAccount" {
  source = "./StorageAccount"
  base_name = "itguts"
  location = "WestUs"
  resource_group_name = module.ResourceGroup.rg_name_out
}