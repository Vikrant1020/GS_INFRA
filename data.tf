
data "azurerm_key_vault" "root" {
  name                = "root"
  resource_group_name = "vikrant"
}

data "azurerm_key_vault_secret" "github_token" {
  name         = "github-token"
  key_vault_id = data.azurerm_key_vault.root.id
}

data "azurerm_key_vault_secret" "pipeline_token" {
  name         = "pipeline-token"
  key_vault_id = data.azurerm_key_vault.root.id
}
