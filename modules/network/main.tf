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

# 🚨 HIGH-RISK CHANGE — SHARED NSG
resource "azurerm_network_security_group" "shared_nsg" {
  name                = "nsg-shared-core"
  location            = var.location
  resource_group_name = azurerm_resource_group.shared.name

  security_rule {
    name                       = "allow-all-inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}

# 🚨 HIGH BLAST RADIUS — NSG ATTACHED TO CORE SUBNET
resource "azurerm_subnet_network_security_group_association" "core_assoc" {
  subnet_id                 = azurerm_subnet.core.id
  network_security_group_id = azurerm_network_security_group.shared_nsg.id
}
