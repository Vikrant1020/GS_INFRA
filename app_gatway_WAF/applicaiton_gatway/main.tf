
# resource "azurerm_application_gateway" "example" {
#   name                = var.gatway_name
#   resource_group_name = var.rg_name
#   location            = var.rg_location

#   sku {
#     name     = "Standard_v2"
#     tier     = "Standard_v2"
#     capacity = 2
#   }

#   gateway_ip_configuration {
#     name      = "gateway"
#     subnet_id = var.subnet_id
#   }

#   frontend_port {
#     name = "frontend"
#     port = 80
#   }

#   frontend_ip_configuration {
#     name                 = "public"
#     public_ip_address_id = var.public_ip
#   }

#   frontend_ip_configuration {
#     name                            = "privetalk-link"
#     subnet_id                       = var.subnet_id
#     private_ip_address_allocation   = "Static"
#     private_ip_address              = "10.0.1.10"
#     private_link_configuration_name = "privetalk-link"
#   }

# #   private_link_configuration {
# #     name = "privetalk-link"
# #     ip_configuration {
# #       name                          = "primary"
# #       subnet_id                     = var.subnet_id
# #       private_ip_address_allocation = "Dynamic"
# #       primary                       = true
# #     }
# #   }

#   backend_address_pool {
#     name = "backend"
#   }

#   backend_http_settings {
#     name                  = "settings"
#     cookie_based_affinity = "Disabled"
#     port                  = 80
#     protocol              = "Http"
#     request_timeout       = 1
#   }

#   http_listener {
#     name                           = "listener"
#     frontend_ip_configuration_name = "private"
#     frontend_port_name             = "frontend"
#     protocol                       = "Http"
#   }

#   request_routing_rule {
#     name                       = "rule"
#     rule_type                  = "Basic"
#     http_listener_name         = "listener"
#     backend_address_pool_name  = "backend"
#     backend_http_settings_name = "settings"
#   }
# }
locals {
  backend_address_pool_name      = "${var.gatway_name}-beap"
  frontend_port_name             = "${var.gatway_name}-feport"
  frontend_ip_configuration_name = "${var.gatway_name}-feip"
  http_setting_name              = "${var.gatway_name}-be-htst"
  listener_name                  = "${var.gatway_name}-httplstn"
  request_routing_rule_name      = "${var.gatway_name}-rqrt"
  redirect_configuration_name    = "${var.gatway_name}-rdrcfg"
}

resource "azurerm_application_gateway" "network" {
  name                = var.gatway_name
  resource_group_name = var.rg_name
  location            = var.rg_location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = var.public_ip
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    priority                   = 120
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}