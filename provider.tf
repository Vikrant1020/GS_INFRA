terraform {
  required_providers {

    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.63.0"
    }
    azuredevops = {
      source = "microsoft/azuredevops"
      version = "0.5.0"
    }   
  }
}

provider "azurerm" {
  features {}
}

provider "azuredevops" {
  org_service_url= var.org_service_url
  personal_access_token= data.azurerm_key_vault_secret.pipeline_token.value
}

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
# uxmrvowppsdtumde6kywl2bstjbaz2vc5mbwtepkdr7jnc7p7omq
