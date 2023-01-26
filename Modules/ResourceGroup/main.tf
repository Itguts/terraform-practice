resource "azurerm_resource_group" "rg" {
  name      = "${var.base_name}_RG"
  location  = var.location
}