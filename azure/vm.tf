resource "azurerm_linux_virtual_machine" "myvm" {
  name                  = "example-machine"
  resource_group_name   = azurerm_resource_group.my-rg.name
  location              = azurerm_resource_group.my-rg.location
  size                  = "Standard_F2"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.first-nic.id]

  custom_data = filebase64("customdata.tpl") # simple bash script to install docker

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}
