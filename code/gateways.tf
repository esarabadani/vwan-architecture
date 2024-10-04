# Virtual network gateway in the hub in region01
resource "azurerm_vpn_gateway" "region01-hub-vpn-gateway" {
  name                = "${var.prefix}-${var.region01-resources-location}-vng-pip"
  location            = var.region01-resources-location
  resource_group_name = azurerm_resource_group.region01-resources-rg.name
  scale_unit          = 1
  virtual_hub_id      = azurerm_virtual_hub.region01-hub.id
  bgp_settings {
    asn         = var.region01-hub-vgn-bgp-asn
    peer_weight = 0
  }
}

# VPN Site in the hub in region01
resource "azurerm_vpn_site" "region01-vpn-site" {
  name                = "${var.prefix}-${var.region01-resources-location}-vpn-site"
  resource_group_name = azurerm_resource_group.region01-resources-rg.name
  location            = var.region01-resources-location
  virtual_wan_id      = azurerm_virtual_wan.global-vwan.id
  link {
    name          = "${var.region01-resources-location}-to-onprem-link"
    ip_address    = azurerm_public_ip.onprem-gateway-pip.ip_address
    provider_name = "Microsoft"
    speed_in_mbps = "100"
    bgp {
      asn             = var.onprem-vgn-bgp-asn
      peering_address = azurerm_virtual_network_gateway.onprem-vpn-gateway.bgp_settings[0].peering_addresses[0].default_addresses[0]
    }
  }
}

# VPN Gateway connection in the hub in region01 to the on-premises VPN gateway
resource "azurerm_vpn_gateway_connection" "region01-to-onprem-connection" {
  name               = "${var.prefix}-${var.region01-resources-location}-to-onprem-connection"
  remote_vpn_site_id = azurerm_vpn_site.region01-vpn-site.id
  vpn_gateway_id     = azurerm_vpn_gateway.region01-hub-vpn-gateway.id
  vpn_link {
    name             = "${var.region01-resources-location}-to-onprem-link"
    vpn_site_link_id = azurerm_vpn_site.region01-vpn-site.link[0].id
    bgp_enabled      = true
    shared_key       = var.vpn-shared-key
  }
}

# On-premises virtual network gateway (VPN)
resource "azurerm_virtual_network_gateway" "onprem-vpn-gateway" {
  name                = "${var.prefix}-onprem-vng"
  location            = var.onprem-resources-location
  resource_group_name = azurerm_resource_group.onprem-resources-rg.name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  sku                 = "VpnGw2AZ"
  active_active       = false
  enable_bgp          = true
  generation          = "Generation2"
  bgp_settings {
    asn = var.onprem-vgn-bgp-asn
  }
  ip_configuration {
    name                 = "GatewayIpConfig"
    public_ip_address_id = azurerm_public_ip.onprem-gateway-pip.id
    subnet_id            = azurerm_subnet.onprem-vnet01-gatewaysubnet.id
  }
}

resource "azurerm_public_ip" "onprem-gateway-pip" {
  name                = "${var.prefix}-onprem-vng-pip"
  resource_group_name = azurerm_resource_group.onprem-resources-rg.name
  location            = var.onprem-resources-location
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
}

# Local network gateway representing the public IP address of the gateway in the hub in region01
resource "azurerm_local_network_gateway" "region01-local-gateway" {
  name                = "${var.prefix}-${var.region01-resources-location}-hub-lng"
  location            = var.region01-resources-location
  resource_group_name = azurerm_resource_group.region01-resources-rg.name
  gateway_address     = tolist(azurerm_vpn_gateway.region01-hub-vpn-gateway.bgp_settings[0].instance_0_bgp_peering_address[0].tunnel_ips)[1]
  bgp_settings {
    asn                 = var.region01-hub-vgn-bgp-asn
    bgp_peering_address = tolist(azurerm_vpn_gateway.region01-hub-vpn-gateway.bgp_settings[0].instance_0_bgp_peering_address[0].default_ips)[0]
  }
}

# VPN Gateway Connection from on-premises VPN gateway to the VPN gateway in the hub in region01
resource "azurerm_virtual_network_gateway_connection" "onprem-to-region01-connection" {
  name                       = "${var.prefix}-onprem-to-${var.region01-resources-location}-connection"
  location                   = var.onprem-resources-location
  resource_group_name        = azurerm_resource_group.onprem-resources-rg.name
  type                       = "IPsec"
  shared_key                 = var.vpn-shared-key
  virtual_network_gateway_id = azurerm_virtual_network_gateway.onprem-vpn-gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.region01-local-gateway.id
  enable_bgp                 = true
}