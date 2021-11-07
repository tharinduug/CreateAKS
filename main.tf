######################## CONFIGURE MS AZURE PROVIDER ############################

provider "azurerm" {
  
  features {}
}


module "rg" {
  source = "./Modules/rg"
}

#resource "azurerm_resource_group" "AFS-AKS" {
#  name     = "${(var.prefix)}-RG"
#  location = "${(var.location)}"
  
#}
module "nsg" {
  source = "./Modules/nsg"
  location            = module.rg.rg_location
  resource_group_name = module.rg.rg_name
}
#resource "azurerm_network_security_group" "AFS-SG" {
#  name                = "${(var.prefix)}-SG"
#  location            = module.rg.rg_location
#  resource_group_name = module.rg.rg_name
#}

#resource "azurerm_network_ddos_protection_plan" "AFS-DDOS" {
#  name                = "${(var.prefix)}-ddos"
#  location            = azurerm_resource_group.AFS-AKS.location
#  resource_group_name = azurerm_resource_group.AFS-AKS.name
#}

resource "azurerm_virtual_network" "example" {
  name                = "${(var.prefix)}-vnet"
  location            = azurerm_resource_group.AFS-AKS.location
  resource_group_name = module.rg.rg_name
  address_space       = ["10.1.0.0/16"]

  #ddos_protection_plan {
  #  id     = azurerm_network_ddos_protection_plan.AFS-DDOS.id
  #  enable = true
  #}

  #subnet {
  #  name           = "${(var.prefix)}-subnet"
  #  address_prefix = "10.0.1.0/24"
  #  security_group = azurerm_network_security_group.AFS-SG.id
  #}


  tags = {
    environment = "Test"
  }


}

resource "azurerm_subnet" "subnet" {
  name                 = "${(var.prefix)}-subnet"
  virtual_network_name = azurerm_virtual_network.example.name
  resource_group_name  = azurerm_resource_group.AFS-AKS.name
  address_prefixes     = ["10.1.0.0/22"]
}


# AKS Cluster creation

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "${(var.prefix)}-aks"
  location            = azurerm_resource_group.AFS-AKS.location
  resource_group_name = azurerm_resource_group.AFS-AKS.name
  dns_prefix          = "${(var.prefix)}-k8s"
  
  

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
    vnet_subnet_id  = azurerm_subnet.subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

    addon_profile {
        http_application_routing {
         enabled = true
    }
  }

}
