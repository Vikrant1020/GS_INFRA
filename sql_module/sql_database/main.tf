resource "azurerm_mssql_database" "sql_database" {
  name           = "${var.env}-${var.sql_db_name}"
  server_id      = var.sql_server_id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 50
  sku_name       = var.sql_sku
  geo_backup_enabled = var.geo_backup
  tags = {
    env = var.env
    env_type = var.env_type
  }

}