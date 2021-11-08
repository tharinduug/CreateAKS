resource "azurerm_resource_group" "AFS-AKS" {
  name     = "${(var.prefix)}-RG"
  location = "${(var.location)}"
  }

  resource "azurerm_network_security_group" "AFS-SG" {
  name                = "${(var.prefix)}-SG"
  location            = azurerm_resource_group.AFS-AKS.location
  resource_group_name = azurerm_resource_group.AFS-AKS.name
}

resource "azurerm_virtual_network" "AFS-VNET" {
  name                = "${(var.prefix)}-vnet"
  location            = azurerm_resource_group.AFS-AKS.location
  resource_group_name = azurerm_resource_group.AFS-AKS.name
  address_space       = ["10.1.0.0/16"]

  tags = {
    environment = "${(var.tags)}"
  }
}

resource "azurerm_subnet" "subnet" {
  name                 = "${(var.prefix)}-subnet"
  virtual_network_name = azurerm_virtual_network.AFS-VNET.name
  resource_group_name  = azurerm_resource_group.AFS-AKS.name
  address_prefixes     = ["10.1.0.0/22"]
}