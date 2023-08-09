resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.env}-virtual-network"
  location            =var.rg_location
  resource_group_name = var.rg_name
  address_space  = [var.cidr_v_net]

  tags = {
    env = var.env
    env_type = var.env_type
  }
}