resource "azurerm_resource_group" "shared" {
  name     = "rg-shared-platform"
  location = var.location
}

resource "azurerm_virtual_network" "shared" {
  name                = "vnet-shared"
  location            = var.location
  resource_group_name = azurerm_resource_group.shared.name
  address_space       = var.address_space
}

resource "azurerm_subnet" "core" {
  name                 = "core-subnet"
  resource_group_name  = azurerm_resource_group.shared.name
  virtual_network_name = azurerm_virtual_network.shared.name
  address_prefixes     = ["10.0.0.0/16"]
}
