output "web_app_token" {
  value = azurerm_static_site.dev.api_key
}

output "id" {
  value = azurerm_static_site.dev.id
}

output "default_DNS_name"{
  value = azurerm_static_site.dev.default_host_name
}

output "name" {
  value = azurerm_static_site.dev.name
}