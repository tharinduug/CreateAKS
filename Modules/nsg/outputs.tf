output "nsg_name" {
  value       = azurerm_network_security_group.AFS-AKS.name
  description = "NSG name"
}