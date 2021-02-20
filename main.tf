provider "azurerm" {
  #version = ">2.4.0"
  subscription_id = var.subscription_id
  client_id       = var.client_id 
  client_secret   = var.client_secret  
  tenant_id       = var.tenant_id
  features {}
}

variable "res_group_name" {
  type = string
  default = "terraformgroup"
}

resource "azurerm_resource_group" "rg" {
  name     = var.res_group_name
  location = "West Europe"
}

module "vnet" {
  source = "Azure/vnet/azurerm"
  resource_group_name = var.res_group_name
  address_space = ["10.0.0.0/16"]
  subnet_prefixes=["10.0.1.0/24"]
  subnet_names=["database"]
  vnet_name="test_vnet"
  depends_on = [ azurerm_resource_group.rg]
}

module "linuxservers" {
  source              = "Azure/compute/azurerm"
  resource_group_name = azurerm_resource_group.rg.name
  vm_os_simple        = "UbuntuServer"
  public_ip_dns       = ["linsimplevmips"] // change to a unique name per datacenter region
  vnet_subnet_id      = module.vnet.vnet_subnets[0]
  vm_size             = "Standard_D2s_v3"
  admin_username      = "cloudadmin"
  admin_password      = "Summer2017,.1234567890"
  enable_ssh_key = false
  depends_on = [azurerm_resource_group.rg,module.vnet]
}