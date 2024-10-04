# Route table in region01 associated to subnet01 in vnet01 and vnet02 in region01
resource "azurerm_route_table" "region01-route_table" {
  name                = "${var.prefix}-${var.region01-resources-location}-route-table"
  resource_group_name = azurerm_resource_group.region01-resources-rg.name
  location            = var.region01-resources-location
}

resource "azurerm_route" "region01-route-to-region01-fw" {
  name                   = "route-to-fw"
  route_table_name       = azurerm_route_table.region01-route_table.name
  resource_group_name    = azurerm_resource_group.region01-resources-rg.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.region01-firewall.virtual_hub[0].private_ip_address
}

resource "azurerm_subnet_route_table_association" "region01-vnet01-fw-route-table-association" {
  subnet_id      = azurerm_subnet.region01-vnet01-subnet01.id
  route_table_id = azurerm_route_table.region01-route_table.id
}

resource "azurerm_subnet_route_table_association" "region01-vnet02-fw-route-table-association" {
  subnet_id      = azurerm_subnet.region01-vnet02-subnet01.id
  route_table_id = azurerm_route_table.region01-route_table.id
}

# Route table in onprem region associated to subnet01 in onprem vnet
resource "azurerm_route_table" "onprem-route_table" {
  name                = "${var.prefix}-${var.onprem-resources-location}-route-table"
  resource_group_name = azurerm_resource_group.onprem-resources-rg.name
  location            = var.onprem-resources-location
}

resource "azurerm_route" "onprem-route-to-region01-fw" {
  name                   = "route-to-fw"
  route_table_name       = azurerm_route_table.onprem-route_table.name
  resource_group_name    = azurerm_resource_group.onprem-resources-rg.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.region01-firewall.virtual_hub[0].private_ip_address
}

resource "azurerm_subnet_route_table_association" "onprem-vnet01-fw-route-table-association" {
  subnet_id      = azurerm_subnet.onprem-vnet01-subnet01.id
  route_table_id = azurerm_route_table.onprem-route_table.id
}

# Route table in region02 associated to subnet01 in vnet01 in region02
resource "azurerm_route_table" "region02-route_table" {
  name                = "${var.prefix}-${var.region02-resources-location}-route-table"
  resource_group_name = azurerm_resource_group.region02-resources-rg.name
  location            = var.region02-resources-location
}

resource "azurerm_route" "region02-route-to-region02-fw" {
  name                   = "route-to-fw"
  route_table_name       = azurerm_route_table.region02-route_table.name
  resource_group_name    = azurerm_resource_group.region02-resources-rg.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.region02-firewall.virtual_hub[0].private_ip_address
}

resource "azurerm_subnet_route_table_association" "region02-vnet01-fw-route-table-association" {
  subnet_id      = azurerm_subnet.region02-vnet01-subnet01.id
  route_table_id = azurerm_route_table.region02-route_table.id
}