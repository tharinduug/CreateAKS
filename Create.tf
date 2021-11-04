######################## CONFIGURE MS AZURE PROVIDER ############################

provider "azurerm" {
  version         = "=1.36.0"
  
}

resource "azurerm_resource_group" "AFS-AKS" {
  name     = "${lower(var.prefix)}-RG"
  location = "${(var.location)}"
}

resource "azurerm_network_security_group" "AFS-SG" {
  name                = "${lower(var.prefix)}-SG"
  location            = azurerm_resource_group.AFS-AKS.location
  resource_group_name = azurerm_resource_group.AFS-AKS.name
}

resource "azurerm_network_ddos_protection_plan" "AFS-DDOS" {
  name                = "ddospplan1"
  location            = azurerm_resource_group.AFS-AKS.location
  resource_group_name = azurerm_resource_group.AFS-AKS.name
}

resource "azurerm_virtual_network" "example" {
  name                = "${lower(var.prefix)}-vnet"
  location            = azurerm_resource_group.AFS-AKS.location
  resource_group_name = azurerm_resource_group.AFS-AKS.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.AFS-DDOS.id
    enable = true
  }

  subnet {
    name           = "${lower(var.prefix)}-subnet"
    address_prefix = "10.0.1.0/24"
    security_group = azurerm_network_security_group.AFS-SG.id
  }


  tags = {
    environment = "Test"
  }
}