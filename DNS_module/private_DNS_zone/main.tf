resource "azurerm_private_dns_zone" "DNS" {
  name                = "privatelink.1.azurestaticapps.net"
  resource_group_name = var.rg_name
  tags = {
    env = var.env
    env_type = var.env_type
  }
}