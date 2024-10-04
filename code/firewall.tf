# Add firewall in the hub in region01
resource "azurerm_firewall" "region01-firewall" {
  name                = "${var.prefix}-${var.region01-resources-location}-firewall"
  resource_group_name = azurerm_resource_group.region01-resources-rg.name
  location            = var.region01-resources-location
  sku_name            = "AZFW_Hub"
  sku_tier            = "Premium"
  firewall_policy_id  = azurerm_firewall_policy.region01-firewall-policy.id
  virtual_hub {
    virtual_hub_id = azurerm_virtual_hub.region01-hub.id
    public_ip_count = 1
  }
  # ip_configuration {
  #   name                         = "${var.region01-resources-location}-FWIpConfiguration"
  # }
}

# Azure Firewall Policy for the firewall in region01
resource "azurerm_firewall_policy" "region01-firewall-policy" {
  name                     = "${var.prefix}-${var.region01-resources-location}-firewall-policy"
  resource_group_name      = azurerm_resource_group.region01-resources-rg.name
  location                 = var.region01-resources-location
  threat_intelligence_mode = "Alert"
  sku                      = "Premium"
}

# Azure Firewall Policy Rule Collection Group and Rule Collections for firewall in region01
resource "azurerm_firewall_policy_rule_collection_group" "region01-firewall-NetworkRuleCollectionGroup" {
  name               = "${var.prefix}-NetworkRuleCollectionGroup"
  firewall_policy_id = azurerm_firewall_policy.region01-firewall-policy.id
  priority           = 100
  network_rule_collection {
    name     = "allow-network-rule-collection"
    action   = "Allow"
    priority = 100
    rule {
      name                  = "allow-all"
      description           = "Allow all traffic to the internet"
      protocols             = ["Any"]
      destination_ports     = ["*"]
      source_addresses      = flatten([
        azurerm_subnet.region01-vnet01-subnet01.address_prefixes,
        azurerm_subnet.region01-vnet02-subnet01.address_prefixes,
        azurerm_subnet.onprem-vnet01-subnet01.address_prefixes
      ])
      destination_addresses = ["*"]
    }
  }
}

# Add firewall in the hub in region02
resource "azurerm_firewall" "region02-firewall" {
  name                = "${var.prefix}-${var.region02-resources-location}-firewall"
  resource_group_name = azurerm_resource_group.region02-resources-rg.name
  location            = var.region02-resources-location
  sku_name            = "AZFW_Hub"
  sku_tier            = "Premium"
  firewall_policy_id  = azurerm_firewall_policy.region02-firewall-policy.id
  virtual_hub {
    virtual_hub_id = azurerm_virtual_hub.region02-hub.id
    public_ip_count = 1
  }
  # ip_configuration {
  #   name                         = "${var.region02-resources-location}-FWIpConfiguration"
  # }
}

# Azure Firewall Policy for the firewall in region02
resource "azurerm_firewall_policy" "region02-firewall-policy" {
  name                     = "${var.prefix}-${var.region02-resources-location}-firewall-policy"
  resource_group_name      = azurerm_resource_group.region02-resources-rg.name
  location                 = var.region02-resources-location
  threat_intelligence_mode = "Alert"
  sku                      = "Premium"
}

# Azure Firewall Policy Rule Collection Group and Rule Collections for firewall in region02
resource "azurerm_firewall_policy_rule_collection_group" "region02-firewall-NetworkRuleCollectionGroup" {
  name               = "${var.prefix}-NetworkRuleCollectionGroup"
  firewall_policy_id = azurerm_firewall_policy.region02-firewall-policy.id
  priority           = 100
  network_rule_collection {
    name     = "allow-network-rule-collection"
    action   = "Allow"
    priority = 100
    rule {
      name                  = "allow-all"
      description           = "Allow all traffic to the internet"
      protocols             = ["Any"]
      destination_ports     = ["*"]
      source_addresses      = azurerm_subnet.region02-vnet01-subnet01.address_prefixes
      destination_addresses = ["*"]
    }
  }
}
