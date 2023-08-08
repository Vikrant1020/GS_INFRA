resource "azurerm_mssql_firewall_rule" "example" {
  name             = var.firewall_rule_name
  server_id        = var.sql_server_id
  start_ip_address = var.starting_from_ip
  end_ip_address   = var.ending_ip
}