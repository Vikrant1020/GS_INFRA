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

resource "azurerm_static_site" "dev" {
  name                = "${var.env}-static-site"
  resource_group_name = var.resource_group_name
  location            = "east us 2"
  sku_tier  = "Standard"
  sku_size = "Standard"

  tags = {
    env = var.env
    env_type = var.env_type
  }
}
