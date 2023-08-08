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

variable "pre-fix" {
  type = string
  default = "dev"
}

variable "container_name" {
  type = string
  default = "infra"
}


variable "devops_project" {
  type = string
  default = "dev2"
}
