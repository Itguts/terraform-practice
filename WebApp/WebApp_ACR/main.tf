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

#locals
locals {
 env_variables = {
   DOCKER_REGISTRY_SERVER_URL            = "https://arc01.azurecr.io"
   DOCKER_REGISTRY_SERVER_USERNAME       = "ACR01"
   DOCKER_REGISTRY_SERVER_PASSWORD       = "**************"
 }
}

# Create an App Service Plan with Linux
resource "azurerm_app_service_plan" "appserviceplan" {
  name                = var.app_service_plan
  location            = var.location
  resource_group_name = var.rsgname

  # Define Linux as Host OS
  kind = "Linux"
  reserved = true

  # Choose size
  sku {
    tier = "Standard"
    size = "S1"
  }

}

# Create an Azure Web App for APP Containers in that App Service Plan
resource "azurerm_app_service" "dockerappapi" {
  name                = var.app_service_api_name
  location            = var.location
  resource_group_name = var.rsgname
  app_service_plan_id = "${azurerm_app_service_plan.appserviceplan.id}"

  # Do not attach Storage by default
  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false

    
    # Settings for private Container Registires  
    DOCKER_REGISTRY_SERVER_URL = "terraacr100.azurecr.io"
    DOCKER_REGISTRY_SERVER_USERNAME = "terraacr100"
    DOCKER_REGISTRY_SERVER_PASSWORD = "0L+aDMz6AYnRuxnydaXy4bIElqKi=7Jr"
    
  }
  #or
  #app_settings = local.env_variables

  # Configure Docker Image to load on start
  site_config {
    linux_fx_version = "DOCKER|terraacr100.azurecr.io/cosmosdbapi:0.0.1-RELEASE"
    always_on        = "true"
  }

  identity {
    type = "SystemAssigned"
  }
}
# Create an Azure Web App for UI Containers in that App Service Plan
resource "azurerm_app_service" "dockerappui" {
  name                = var.app_service_ui_name
  location            = var.location
  resource_group_name = var.rsgname
  app_service_plan_id = "${azurerm_app_service_plan.appserviceplan.id}"

  # Do not attach Storage by default
  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    
    # Settings for private Container Registires  
    DOCKER_REGISTRY_SERVER_URL = "terraacr100.azurecr.io"
    DOCKER_REGISTRY_SERVER_USERNAME = "terraacr100"
    DOCKER_REGISTRY_SERVER_PASSWORD = "0L+aDMz6AYnRuxnydaXy4bIElqKi=7Jr"    
    WebAPIBaseUrl = "https://terraacrcosmosapi100.azurewebsites.net/api"
    ASPNETCORE_ENVIRONMENT = "Development"
    
  }

  # Configure Docker Image to load on start
  site_config {
    linux_fx_version = "DOCKER|terraacr100.azurecr.io/cosmosdbui:0.0.1-RELEASE"
    always_on        = "true"
  }

  identity {
    type = "SystemAssigned"
  }
}