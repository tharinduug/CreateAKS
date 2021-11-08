output "rg_name" {
  value       = azurerm_resource_group.AFS-AKS.name
  description = "RG name"
}


output "rg_location" {
  value       = azurerm_resource_group.AFS-AKS.location
  description = "RG location"
}
