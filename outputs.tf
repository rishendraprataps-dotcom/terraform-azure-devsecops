output "resource_group_name" {
  description = "Created Azure resource group."
  value       = azurerm_resource_group.this.name
}

output "virtual_network_name" {
  description = "Created virtual network."
  value       = azurerm_virtual_network.this.name
}

output "subnet_id" {
  description = "Application subnet resource ID."
  value       = azurerm_subnet.app.id
}
