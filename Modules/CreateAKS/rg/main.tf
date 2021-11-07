resource "azurerm_resource_group" "AFS-AKS" {
  name     = "${(var.prefix)}-RG"
  location = "${(var.location)}"
  tags = "${var.tags}"
  
}