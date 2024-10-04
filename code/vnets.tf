resource "azurerm_virtual_network" "region01-vnet01" {
  name                = "${var.prefix}-${var.region01-resources-location}-vnet01"
  location            = var.region01-resources-location
  resource_group_name = azurerm_resource_group.region01-resources-rg.name
  address_space       = [var.region01-vnet01-address-space]
}

resource "azurerm_subnet" "region01-vnet01-subnet01" {
  name                            = "subnet01"
  resource_group_name             = azurerm_resource_group.region01-resources-rg.name
  virtual_network_name            = azurerm_virtual_network.region01-vnet01.name
  address_prefixes                = [var.region01-vnet01-subnet01-address-space]
  default_outbound_access_enabled = false
}

resource "azurerm_virtual_network" "region01-vnet02" {
  name                = "${var.prefix}-${var.region01-resources-location}-vnet02"
  location            = var.region01-resources-location
  resource_group_name = azurerm_resource_group.region01-resources-rg.name
  address_space       = [var.region01-vnet02-address-space]
}

resource "azurerm_subnet" "region01-vnet02-subnet01" {
  name                            = "subnet01"
  resource_group_name             = azurerm_resource_group.region01-resources-rg.name
  virtual_network_name            = azurerm_virtual_network.region01-vnet02.name
  address_prefixes                = [var.region01-vnet02-subnet01-address-space]
  default_outbound_access_enabled = false
}

resource "azurerm_virtual_network" "region02-vnet01" {
  name                = "${var.prefix}-${var.region02-resources-location}-vnet01"
  location            = var.region02-resources-location
  resource_group_name = azurerm_resource_group.region02-resources-rg.name
  address_space       = [var.region02-vnet01-address-space]
}

resource "azurerm_subnet" "region02-vnet01-subnet01" {
  name                            = "subnet01"
  resource_group_name             = azurerm_resource_group.region02-resources-rg.name
  virtual_network_name            = azurerm_virtual_network.region02-vnet01.name
  address_prefixes                = [var.region02-vnet01-subnet01-address-space]
  default_outbound_access_enabled = false
}

resource "azurerm_virtual_network" "onprem-vnet01" {
  name                = "${var.prefix}-${var.onprem-resources-location}-onprem-vnet01"
  location            = var.onprem-resources-location
  resource_group_name = azurerm_resource_group.onprem-resources-rg.name
  address_space       = [var.onprem-vnet01-address-space]
}

resource "azurerm_subnet" "onprem-vnet01-subnet01" {
  name                            = "subnet01"
  resource_group_name             = azurerm_resource_group.onprem-resources-rg.name
  virtual_network_name            = azurerm_virtual_network.onprem-vnet01.name
  address_prefixes                = [var.onprem-vnet01-subnet01-address-space]
  default_outbound_access_enabled = false
}

resource "azurerm_subnet" "onprem-vnet01-gatewaysubnet" {
  name                            = "GatewaySubnet"
  resource_group_name             = azurerm_resource_group.onprem-resources-rg.name
  virtual_network_name            = azurerm_virtual_network.onprem-vnet01.name
  address_prefixes                = [var.onprem-vnet01-gateway-subnet-address-space]
  default_outbound_access_enabled = false
}