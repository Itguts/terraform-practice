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
variable "container_registry_name" {
  type        = string
  description = "Azure Container Registry Name"
  default = "terraacr100"
}