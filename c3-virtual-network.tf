# Create Virtual Network
resource "azurerm_virtual_network" "myvnet" {
  name                = "itvnet-1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.Terraform_RG.location
  resource_group_name = azurerm_resource_group.Terraform_RG.name
  tags = {
      Environment = "Testing"
      Buildby = "Sandeep CH"
      Builddate = "20230211"
    }
}

# Create Subnet
resource "azurerm_subnet" "mysubnet" {
  name                 = "itsubnet-1"
  resource_group_name  = azurerm_resource_group.Terraform_RG.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create Public IP Address
resource "azurerm_public_ip" "mypublicip" {
  name                = "it-publicip-1"
  resource_group_name = azurerm_resource_group.Terraform_RG.name
  location            = azurerm_resource_group.Terraform_RG.location
  allocation_method   = "Static"
  domain_name_label = "app1-vm-${random_string.myrandom.id}"
  tags = {
      Environment = "Testing"
      Buildby = "Sandeep CH"
      Builddate = "20230211"
    } 
}

# Create Network Interface
resource "azurerm_network_interface" "myvmnic" {
  name                = "it-vmnic"
  location            = azurerm_resource_group.Terraform_RG.location
  resource_group_name = azurerm_resource_group.Terraform_RG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.mypublicip.id 
  }
  tags = {
      Environment = "Testing"
      Buildby = "Sandeep CH"
      Builddate = "20230211"
    }
}