

resource "azurerm_linux_virtual_machine" "polaris" {
  name                            = var.name
  resource_group_name             = var.rg_name
  location                        = var.location
  size                            = "Standard_B1s"
  admin_username                  = data.azurerm_key_vault_secret.vm-username.value
  admin_password                  = data.azurerm_key_vault_secret.vm-password.value
  disable_password_authentication = false
  network_interface_ids = [
    data.azurerm_network_interface.polaris_nic.id
  ]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }
   custom_data = var.custom_data
}