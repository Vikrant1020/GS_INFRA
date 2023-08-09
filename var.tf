variable "org_service_url" {
    type = string
    default = "https://dev.azure.com/Vikrant-practice/"
}

variable "github_branch" {
  type = string
  default = "main"
}

variable "ymlpath" {
  type = string
  default = "/devops.yml"
}

variable "github_repo" {
  type = string
  default = "vikrant1020/react-Appspec"
}

variable "environment" {
  type = string
  default = "dev"
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["dev", "prod","qa","uat"], var.environment)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}

variable "environment_type" {
  type = string
  default = "nonprod"
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["nonprod", "prod"], var.environment_type)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}

variable "devops_project" {
  type = string
  default = "GS-dev"
  description = "Enter the Azure Devops Environment"
  validation {
    condition = contains(["GS-dev","GS-prod","GS-qa","GS-uat"], var.devops_project)
    error_message = "Please enter a valid value from: GS-dev GS-qa GS-uat GS-prod"
  }
}


variable "subresource_name" {
  type = list(string)
  default =["staticSites"]
  validation {
    condition = alltrue([
      for i in var.subresource_name : contains(["staticSites","SQL","application gateway","Blob","vault","dataFactory"], i)])
    error_message = "Please enter valid values from: staticSites, SQL, application gateway, Blob, vault, dataFactory"
  }
}
