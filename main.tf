######################## CONFIGURE MS AZURE PROVIDER ############################

provider "azurerm" {

  features {}
}


module "rg" {
  source = "./Modules/vnet"
  prefix = "AFS"
  location  = "West US 2"

}

# AKS Cluster creation

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "${(var.prefix)}-aks"
  location            = module.rg.rg_location
  resource_group_name = module.rg.rg_name
  dns_prefix          = "${(var.prefix)}-k8s"
  
  

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
    vnet_subnet_id  = module.rg.subnetID
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
