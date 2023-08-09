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

resource "azurerm_resource_group" "dev" {
  name = var.rg_name
  location = var.rg_location
}

resource "azuredevops_project" "dev" {
  name               = var.azuredevops_name
  visibility         = "private"
  version_control    = "Git"
  work_item_template = "Agile"
}

resource "azuredevops_serviceendpoint_github" "github" {
  project_id            = azuredevops_project.dev.id
  service_endpoint_name = "Github Service endpoint"

  auth_personal {
    personal_access_token = var.github_token #data.azurerm_key_vault_secret.github_token.value
  }
}