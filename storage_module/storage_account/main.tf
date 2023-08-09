resource "azurerm_storage_account" "storage" {
  name                     = "${var.env}greensight"
  resource_group_name      = var.rg_name
  location                 = var.rg_location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  public_network_access_enabled = true

  tags = {
    env = var.env
    env_type = var.env_type
  }
}


