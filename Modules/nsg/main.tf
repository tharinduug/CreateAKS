resource "azurerm_network_security_group" "AFS-SG" {
  name                = "${(var.prefix)}-SG"
}