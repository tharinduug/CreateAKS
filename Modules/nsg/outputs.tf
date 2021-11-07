output "nsg_name" {
  value       = azurerm_network_security_group.AFS-SG.name
  description = "NSG name"
}