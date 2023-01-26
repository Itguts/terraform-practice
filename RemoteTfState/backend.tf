terraform {
   backend "azurerm" {
      resource_group_name = "itgutsterraformrg"
      storage_account_name = "itgutsterraformstg"
      container_name = "tfstates"
      key = "terraform.tfstate"
  }
}