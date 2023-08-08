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

resource "azuredevops_build_definition" "dev_api" {
  project_id = var.project_id #azuredevops_project.dev.id
  name       = var.name
  path       = "\\"

  ci_trigger {
    use_yaml = true
  }

 repository {
    repo_type             = "GitHub"
    repo_id               = var.github_repo
    branch_name           = var.github_branch
    yml_path              = var.ymlpath
    service_connection_id = var.github_service_connection #azuredevops_serviceendpoint_github.github.id
  }

  variable {
    name  = "STATIC_WEB_APP_TOKEN"
    value = var.web_app_token #azurerm_static_site.dev.api_key
  }
}