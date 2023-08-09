output "devops_project" {
  value = azuredevops_project.dev.id
}

output "github_service_connection" {
  value = azuredevops_serviceendpoint_github.github.id
}

output "resource_group_name" {
  value = azurerm_resource_group.dev.name
}

output "resource_group_location" {
  value = azurerm_resource_group.dev.location
}