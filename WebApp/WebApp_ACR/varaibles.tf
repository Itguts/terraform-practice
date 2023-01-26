variable "location" {
    type = string
    description = "location for the depoloyment"
    default = "EastUs"
}
variable "rsgname" {
    type = string
    description = "name for the resource group"
    default = "terrarsg"
}
variable "app_service_plan" {
  type        = string
  description = "App plan Name"
  default = "terraacrappplan"
}
variable "app_service_api_name" {
  type        = string
  description = "App Service Name for API"
  default = "terraacrcosmosapi100"
}
variable "app_service_ui_name" {
  type        = string
  description = "App Service Name for UI"
  default = "terraacrcosmosui100"
}