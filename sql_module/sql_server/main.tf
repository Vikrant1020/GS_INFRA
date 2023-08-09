resource "azurerm_mssql_server" "sql_server" {
  name                         = "${var.env}-${var.sql_server_name}"
  resource_group_name          = var.rg_name
  location                     = var.rg_location
  version                      = "12.0"
  administrator_login          = var.sql_username
  administrator_login_password = var.sql_password

  tags = {
    env = var.env
    env_type = var.env_type
  }
}
