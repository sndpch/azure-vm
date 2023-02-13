# Resource: Azure Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "mylinuxvm" {
    admin_username = "azureuser"
    admin_password = "Password@12345"
    disable_password_authentication = false
    location = azurerm_resource_group.Terraform_RG.location
    name = "sandylinuxvm-1"
    computer_name = "sandylinuxvm-1" # Hostname for the VM
    network_interface_ids = [ azurerm_network_interface.myvmnic.id ]
    resource_group_name = azurerm_resource_group.Terraform_RG.name
    size = "Standard D2s v3"
    os_disk {
        name = "osdisk"
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
    }
    
}