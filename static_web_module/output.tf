output "web_app_token" {
  value = azurerm_static_site.dev.api_key
}

output "id" {
  value = azurerm_static_site.dev.id
}