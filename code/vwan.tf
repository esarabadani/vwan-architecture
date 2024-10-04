resource "azurerm_virtual_wan" "global-vwan" {
  name                           = "${var.prefix}-vwan"
  location                       = var.shared-resources-location
  resource_group_name            = azurerm_resource_group.shared-rg.name
  allow_branch_to_branch_traffic = true
  type                           = "Standard"
}

resource "azurerm_virtual_hub" "region01-hub" {
  name                = "${var.prefix}-${var.region01-resources-location}-hub"
  location            = var.region01-resources-location
  resource_group_name = azurerm_resource_group.shared-rg.name
  virtual_wan_id      = azurerm_virtual_wan.global-vwan.id
  address_prefix      = var.region01-vwan-hub-address-prefix
  hub_routing_preference = "VpnGateway"
  sku = "Standard"
}

resource "azurerm_virtual_hub_connection" "region01-vnet01-connection" {
  name = "${var.prefix}-${var.region01-resources-location}-vnet01-connection"
  virtual_hub_id = azurerm_virtual_hub.region01-hub.id
  remote_virtual_network_id = azurerm_virtual_network.region01-vnet01.id
}

resource "azurerm_virtual_hub_connection" "region01-vnet02-connection" {
  name = "${var.prefix}-${var.region01-resources-location}-vnet02-connection"
  virtual_hub_id = azurerm_virtual_hub.region01-hub.id
  remote_virtual_network_id = azurerm_virtual_network.region01-vnet02.id
}

resource "azurerm_virtual_hub" "region02-hub" {
  name                = "${var.prefix}-${var.region02-resources-location}-hub"
  location            = var.region02-resources-location
  resource_group_name = azurerm_resource_group.shared-rg.name
  virtual_wan_id      = azurerm_virtual_wan.global-vwan.id
  address_prefix      = var.region02-vwan-hub-address-prefix
  hub_routing_preference = "VpnGateway"
  sku = "Standard"
}

resource "azurerm_virtual_hub_connection" "region02-vnet01-connection" {
  name = "${var.prefix}-${var.region02-resources-location}-vnet01-connection"
  virtual_hub_id = azurerm_virtual_hub.region02-hub.id
  remote_virtual_network_id = azurerm_virtual_network.region02-vnet01.id
}