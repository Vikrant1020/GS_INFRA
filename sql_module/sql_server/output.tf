output "sql_server_id" {
  value = azurerm_mssql_server.sql_server.id
}

output "sql_admin_user" {
  value = azurerm_mssql_server.sql_server.administrator_login
}

output "sql_admin_password" {
  value = azurerm_mssql_server.sql_server.administrator_login_password
}