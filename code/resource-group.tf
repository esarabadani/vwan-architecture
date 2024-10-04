resource "azurerm_resource_group" "shared-rg" {
  name     = "${var.prefix}-${var.shared-resources-location}-shared-rg"
  location = var.shared-resources-location
}

resource "azurerm_resource_group" "region01-resources-rg" {
  name     = "${var.prefix}-${var.region01-resources-location}-resources-rg"
  location = var.region01-resources-location
}

resource "azurerm_resource_group" "region02-resources-rg" {
  name     = "${var.prefix}-${var.region02-resources-location}-resources-rg"
  location = var.region02-resources-location
}

resource "azurerm_resource_group" "onprem-resources-rg" {
  name     = "${var.prefix}-${var.onprem-resources-location}-resources-rg"
  location = var.region01-resources-location
}