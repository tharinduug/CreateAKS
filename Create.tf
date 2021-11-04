######################## CONFIGURE MS AZURE PROVIDER ############################

provider "azurerm" {
  version = "=2.0.0"
  features {}
}

# refer to a resource group
data "azurerm_resource_group" "rg" {
  name = "AFS"
}

data "azurerm_virtual_network" "vnetPrimary" {
  name                = "AFS-vnet1"
  resource_group_name = "AFS"
}

#refer to a subnet
data "azurerm_subnet" "subnet" {
  name                 = "AFS-subnet"
  virtual_network_name = "AFS-vnet1"
  resource_group_name  = "AFS-rg"
}

data "azurerm_network_security_group" "demo" {
  name                = "AFS-subnet-nsg"
  resource_group_name = "AFS-rg"
}

data "azurerm_application_security_group" "demo" {
  name                = "AFS-asg"
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_public_ip" "ifsapprce" {
  name                = "AFS-pip"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
  domain_name_label   = "AFS-dmo"
}

resource "azurerm_network_interface" "ifsapprce" {
  name                      = "AFS-nic"
  location                  = data.azurerm_resource_group.rg.location
  resource_group_name       = data.azurerm_resource_group.rg.name
  network_security_group_id = data.azurerm_network_security_group.demo.id

  ip_configuration {
    name                           = "AFS-conf"
    subnet_id                      = data.azurerm_subnet.subnet.id
    private_ip_address_allocation  = "Dynamic"
    public_ip_address_id           = azurerm_public_ip.ifsapprce.id
    application_security_group_ids = [data.azurerm_application_security_group.demo.id]
  }
}

resource "azurerm_network_interface_application_security_group_association" "demo" {
  network_interface_id          = azurerm_network_interface.ifsapprce.id
  ip_configuration_name         = "AFS-conf"
  application_security_group_id = data.azurerm_application_security_group.demo.id
}