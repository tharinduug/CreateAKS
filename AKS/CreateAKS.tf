######################## CONFIGURE MS AZURE PROVIDER ############################

provider "azurerm" {
        subscription_id = var.subscription_id
        client_id = var.client_id
        client_secret = var.client_secret
        tenant_id = var.tenant_id

        version = "~>2.0"
        features {}
}

# refer to a resource group
data "azurerm_resource_group" "rg" {
  name = "AFS"
}

