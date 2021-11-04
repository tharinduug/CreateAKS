######################## CONFIGURE MS AZURE PROVIDER ############################

provider "azurerm" {
        version = "~>2.0"
        features {}
}

# refer to a resource group
data "azurerm_resource_group" "rg" {
  name = "AFS"
}

