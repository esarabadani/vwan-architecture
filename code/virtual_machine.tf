# VM deployed in regin01 connected to vnet01
resource "azurerm_public_ip" "region01-vnet01-vm01-pip" {
  name                = "${azurerm_virtual_network.region01-vnet01.name}-vm01-pip"
  resource_group_name = azurerm_resource_group.region01-resources-rg.name
  location            = var.region01-resources-location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "region01-vnet01-vm01-nic" {
  name                = "${azurerm_virtual_network.region01-vnet01.name}-vm01-nic"
  location            = var.region01-resources-location
  resource_group_name = azurerm_resource_group.region01-resources-rg.name

  ip_configuration {
    name                          = "region01-vnet01-vm01-ipconfig"
    subnet_id                     = azurerm_subnet.region01-vnet01-subnet01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.region01-vnet01-vm01-pip.id
  }
}

resource "azurerm_virtual_machine" "region01-vnet01-vm01" {
  name                  = "${azurerm_virtual_network.region01-vnet01.name}-vm01"
  location              = var.region01-resources-location
  resource_group_name   = azurerm_resource_group.region01-resources-rg.name
  network_interface_ids = [azurerm_network_interface.region01-vnet01-vm01-nic.id]
  vm_size               = "Standard_D2s_v3"

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  storage_os_disk {
    name              = "region01-vnet01-vm01-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${azurerm_virtual_network.region01-vnet01.name}-vm01"
    admin_username = var.vm_username
    admin_password = var.vm_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# VM deployed in regin01 connected to vnet02
resource "azurerm_public_ip" "region01-vnet02-vm01-pip" {
  name                = "${azurerm_virtual_network.region01-vnet02.name}-vm01-pip"
  resource_group_name = azurerm_resource_group.region01-resources-rg.name
  location            = var.region01-resources-location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "region01-vnet02-vm01-nic" {
  name                = "${azurerm_virtual_network.region01-vnet02.name}-vm01-nic"
  location            = var.region01-resources-location
  resource_group_name = azurerm_resource_group.region01-resources-rg.name

  ip_configuration {
    name                          = "region01-vnet02-vm01-ipconfig"
    subnet_id                     = azurerm_subnet.region01-vnet02-subnet01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.region01-vnet02-vm01-pip.id
  }
}

resource "azurerm_virtual_machine" "region01-vnet02-vm01" {
  name                  = "${azurerm_virtual_network.region01-vnet02.name}-vm01"
  location              = var.region01-resources-location
  resource_group_name   = azurerm_resource_group.region01-resources-rg.name
  network_interface_ids = [azurerm_network_interface.region01-vnet02-vm01-nic.id]
  vm_size               = "Standard_D2s_v3"

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  storage_os_disk {
    name              = "region01-vnet02-vm01-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${azurerm_virtual_network.region01-vnet02.name}-vm01"
    admin_username = var.vm_username
    admin_password = var.vm_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# VM deployed in onprem connected to vnet01
resource "azurerm_public_ip" "onprem-vnet01-vm01-pip" {
  name                = "${azurerm_virtual_network.onprem-vnet01.name}-vm01-pip"
  resource_group_name = azurerm_resource_group.onprem-resources-rg.name
  location            = var.onprem-resources-location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "onprem-vnet01-vm01-nic" {
  name                = "${azurerm_virtual_network.onprem-vnet01.name}-vm01-nic"
  location            = var.onprem-resources-location
  resource_group_name = azurerm_resource_group.onprem-resources-rg.name

  ip_configuration {
    name                          = "onprem-vnet01-vm01-ipconfig"
    subnet_id                     = azurerm_subnet.onprem-vnet01-subnet01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.onprem-vnet01-vm01-pip.id
  }
}

resource "azurerm_virtual_machine" "onprem-vnet01-vm01" {
  name                  = "${azurerm_virtual_network.onprem-vnet01.name}-vm01"
  location              = var.onprem-resources-location
  resource_group_name   = azurerm_resource_group.onprem-resources-rg.name
  network_interface_ids = [azurerm_network_interface.onprem-vnet01-vm01-nic.id]
  vm_size               = "Standard_D2s_v3"

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  storage_os_disk {
    name              = "onprem-vnet01-vm01-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${azurerm_virtual_network.onprem-vnet01.name}-vm01"
    admin_username = var.vm_username
    admin_password = var.vm_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# VM deployed in regin02 connected to vnet01
resource "azurerm_public_ip" "region02-vnet01-vm01-pip" {
  name                = "${azurerm_virtual_network.region02-vnet01.name}-vm01-pip"
  resource_group_name = azurerm_resource_group.region02-resources-rg.name
  location            = var.region02-resources-location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "region02-vnet01-vm01-nic" {
  name                = "${azurerm_virtual_network.region02-vnet01.name}-vm01-nic"
  location            = var.region02-resources-location
  resource_group_name = azurerm_resource_group.region02-resources-rg.name

  ip_configuration {
    name                          = "region02-vnet01-vm01-ipconfig"
    subnet_id                     = azurerm_subnet.region02-vnet01-subnet01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.region02-vnet01-vm01-pip.id
  }
}

resource "azurerm_virtual_machine" "region02-vnet01-vm01" {
  name                  = "${azurerm_virtual_network.region02-vnet01.name}-vm01"
  location              = var.region02-resources-location
  resource_group_name   = azurerm_resource_group.region02-resources-rg.name
  network_interface_ids = [azurerm_network_interface.region02-vnet01-vm01-nic.id]
  vm_size               = "Standard_D2s_v3"

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  storage_os_disk {
    name              = "region02-vnet01-vm01-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${azurerm_virtual_network.region02-vnet01.name}-vm01"
    admin_username = var.vm_username
    admin_password = var.vm_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}
