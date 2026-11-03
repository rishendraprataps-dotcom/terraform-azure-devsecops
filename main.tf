resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = var.environment
    managed_by  = "terraform"
    project     = "devsecops-demo"
  }
}

resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = var.address_space

  tags = {
    environment = var.environment
    managed_by  = "terraform"
  }
}

resource "azurerm_subnet" "app" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.subnet_prefixes
}
