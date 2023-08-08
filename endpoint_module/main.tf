resource "azurerm_private_endpoint" "ep" {
  name                = var.name
  location            = var.rg_location
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = var.link_name
    private_connection_resource_id = var.pe_resource_id
    is_manual_connection           = false
    subresource_names              = ["staticSites"]
  }
  tags = {
    "env": var.env
  }
}