resource "azurerm_network_security_group" "AFS-SG" {
  name                = "${(var.prefix)}-SG"
  location = "${(var.location)}"
  resource_group_name = "${(var.rgname)}"
}