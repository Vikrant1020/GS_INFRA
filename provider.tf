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

