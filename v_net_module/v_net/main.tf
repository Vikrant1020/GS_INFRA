resource "azurerm_virtual_network" "example" {
  name                = var.v_net_name
  location            =var.rg_location
  resource_group_name = var.rg_name
  address_space  = [var.cidr_v_net]

}