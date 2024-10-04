variable "prefix" {
  description = "Prefix for all resources in this scenario"
  type        = string
}

variable "shared-resources-location" {
  description = "Location for all shared resources in this scenario"
  type        = string
  default = "germanywestcentral"
}

variable "region01-resources-location" {
  description = "Location for all resources in location1 in this scenario"
  type        = string
  default = "germanywestcentral"
}

variable "region02-resources-location" {
  description = "Location for all resources in location2 in this scenario"
  type        = string
  default = "swedencentral"
}

variable "onprem-resources-location" {
  description = "Location for all on-premises resources in this scenario"
  type        = string
  default = "uksouth"
}

variable "region01-vwan-hub-address-prefix" {
  description = "Address prefix for the hub in region01"
  type        = string
  default = "10.0.0.0/16" 
}

variable "region02-vwan-hub-address-prefix" {
  description = "Address prefix for the hub in region01"
  type        = string
  default = "10.1.0.0/16" 
}

variable "region01-vnet01-address-space" {
  description = "Address prefix for the vnet01 in region01"
  type        = string
  default = "10.2.0.0/16" 
}

variable "region01-vnet01-subnet01-address-space" {
  description = "Address prefix for the subnet01 in vnet01 in region01"
  type        = string
  default = "10.2.0.0/24" 
}

variable "region01-vnet02-address-space" {
  description = "Address prefix for the vnet02 in region01"
  type        = string
  default = "10.3.0.0/16" 
}

variable "region01-vnet02-subnet01-address-space" {
  description = "Address prefix for the subnet01 in vnet02 in region01"
  type        = string
  default = "10.3.0.0/24" 
}

variable "region02-vnet01-address-space" {
  description = "Address prefix for the vnet01 in region02"
  type        = string
  default = "10.4.0.0/16"
}

variable "region02-vnet01-subnet01-address-space" {
  description = "Address prefix for the subnet01 in vnet01 in region02"
  type        = string
  default = "10.4.0.0/24"
}

variable "onprem-vnet01-address-space" {
  description = "Address prefix for the onpremises vnet in region01"
  type        = string
  default = "10.5.0.0/16"
}

variable "onprem-vnet01-subnet01-address-space" {
  description = "Address prefix for the subnet01 in onpremises vnet in region01"
  type        = string
  default = "10.5.0.0/24"
}

variable "onprem-vnet01-gateway-subnet-address-space" {
  description = "Address prefix for the GatewaySubnet in onpremises vnet in region01"
  type        = string
  default = "10.5.1.0/24"
}

variable "onprem-vgn-bgp-asn" {
  description = "BGP ASN for the on-premises VPN gateway"
  type        = number
  default = 65050
}

variable "region01-hub-vgn-bgp-asn" {
  description = "BGP ASN for the VPN gateway in the hub in region01"
  type        = number
  default = 65515
}

variable "vpn-shared-key" {
  description = "value for the VPN tunnel shared key"
  type = string
  default = "esmaeil12345"
}

variable "vm_username" {
  description = "Password for the VMs"
  type        = string
  default     = "esmaeil"
}

variable "vm_password" {
  description = "Password for the VMs"
  type        = string
  default     = "P@ssw0rd12345"
}