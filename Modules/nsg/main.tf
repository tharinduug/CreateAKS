resource "azurerm_network_security_group" "AFS-SG" {
  name                = "${(var.prefix)}-SG"
  location            = "${(var.location)}-SG"
  resource_group_name = ["${module.rg.rg_name}"]
}