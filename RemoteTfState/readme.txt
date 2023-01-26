RESOURCE_GROUP_NAME=tfstate
STORAGE_ACCOUNT_NAME=tfstate$RANDOM
CONTAINER_NAME=tfstate

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

then
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
export ARM_ACCESS_KEY=$ACCOUNT_KEY

then
export ARM_ACCESS_KEY=$(az keyvault secret show --name terraform-backend-key --vault-name myKeyVault --query value -o tsv)

----------or--------------
Create a storrage account, container
terraform {

  required_version = ">=0.12"
  
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "~>2.0"
      } 
  }
  backend "azurerm" {
      resource_group_name = "itgutsterraformrg"
      storage_account_name = "itgutsterraformstg"
      container_name = "tfstates"
      key = "terraform.tfstate"
  }
}
In main.tf
or create a backend.tf
