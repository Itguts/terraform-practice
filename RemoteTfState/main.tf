terraform {

  required_version = ">=0.12"
  
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "~>2.0"
      } 
  }
  # backend "azurerm" {
  #     resource_group_name = "itgutsterraformrg"
  #     storage_account_name = "itgutsterraformstg"
  #     container_name = "tfstates"
  #     key = "terraform.tfstate"
  # }
}

provider "azurerm" {
  features {}
}
variable "location" {
    type = string
    description = "location for the depoloyment"
    default = "EastUs"
}
variable "rsgname" {
    type = string
    description = "name for the resource group"
    default = "itguts_rsg"
}


resource "azurerm_resource_group" "rg" {
  name      = var.rsgname
  location  = var.location
}
