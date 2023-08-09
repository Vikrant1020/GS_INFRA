module "environment" {
    source = "./rg_pipeline_env_module"
    azuredevops_name = var.devops_project
    github_token = data.azurerm_key_vault_secret.github_token.value
    rg_location = "East US"
    rg_name = "greensight-dev-rg"
}

module "pipeline" {
    source = "./pipeline_module/frontend"
    name = "${var.environment}-frontend"
    github_repo = var.github_repo
    github_branch = var.github_branch
    ymlpath = var.ymlpath
    github_service_connection = module.environment.github_service_connection
    project_id = module.environment.devops_project
    web_app_token = module.frontend.web_app_token
    depends_on = [
    module.environment , module.frontend
  ]
}

module "frontend" {
  source = "./static_web_module"
  resource_group_name = module.environment.resource_group_name
  env = var.environment
}

module "vnet" {
  source = "./v_net_module/v_net"
  rg_location = module.environment.resource_group_location
  rg_name = module.environment.resource_group_name
  cidr_v_net = "10.0.0.0/16"
}

module "private_link_subnet" {
  source = "./v_net_module/subnet"
  subnet_name = "${var.environment}-private-link-subnet"
  rg_name = module.environment.resource_group_name
  subnet_cidr = "10.0.1.0/24"
  v_net_name = module.vnet.v_net_name
}

module "application_gatway_subnet" {
  source = "./v_net_module/subnet"
  subnet_name = "${var.environment}-application_gatway-subnet"
  rg_name = module.environment.resource_group_name
  subnet_cidr = "10.0.3.0/24"
  v_net_name = module.vnet.v_net_name
}

module "network_interface_subnet" {
  source = "./v_net_module/subnet"
  subnet_name = "${var.environment}-network-interface-subnet"
  rg_name = module.environment.resource_group_name
  subnet_cidr = "10.0.2.0/24"
  v_net_name = module.vnet.v_net_name
}

module "DNS" {
  source = "./DNS_module/private_DNS_zone"
  DNS_name = "${var.environment}-greensight"
  rg_name  = module.environment.resource_group_name
}

module "endpoint_frontend" {
  source = "./endpoint_module"
  rg_location = module.environment.resource_group_location
  rg_name = module.environment.resource_group_name
  subnet_id = module.private_link_subnet.subnet_id
  link_name = "${module.frontend.name}"
  pe_resource_id = module.frontend.id
  env = var.environment
  DNS_id = module.DNS.id
  DNS_zone_name = "${var.environment}-gs-test"
  subresource_name = var.subresource_name
  depends_on = [
    module.environment , module.private_link_subnet , module.frontend , module.DNS
  ]
}

module "storage" {
  source = "./storage_module/storage_account"
  env = var.environment
  rg_name = module.environment.resource_group_name
  rg_location = module.environment.resource_group_location
}

module "infra" {
  source = "./storage_module/container"
  storage_name = module.storage.storage_account_name
  container_name = "infra"
}

module "appdata" {
  source = "./storage_module/container"
  storage_name = module.storage.storage_account_name
  container_name = "appdata"
}

module "logs" {
  source = "./storage_module/container"
  storage_name = module.storage.storage_account_name
  container_name = "logs"
}

module "client" {
  source = "./storage_module/container"
  storage_name = module.storage.storage_account_name
  container_name =  "client"
}

module "rawbackup" {
  source = "./storage_module/container"
  storage_name = module.storage.storage_account_name
  container_name =  "rawbackup"
}

module "transformedbackend" {
  source = "./storage_module/container"
  storage_name = module.storage.storage_account_name
  container_name =  "transformedbackend"
}

module "lifecycle_raw_backup" {
  source = "./storage_module/lifecycle"
  lifecyle_rule_name = "${module.rawbackup.name}-lificycle-rule"
  container_name = module.rawbackup.name
  storage_account_id = module.storage.storage_account_id
  rule_enable = true
  time_to_move_to_cool = 14
  time_to_move_to_archive = 90
}

module "lifecycle_transformed_backup" {
  source = "./storage_module/lifecycle"
  lifecyle_rule_name = "${module.transformedbackend.name}-lificycle-rule"
  container_name = module.transformedbackend.name
  storage_account_id = module.storage.storage_account_id
  rule_enable = true
  time_to_move_to_cool = 14
  time_to_move_to_archive = 90
}

module "EP_record_private_DNS" {
  source = "./DNS_module/add_reacord"
  private_ip = module.endpoint_frontend.ip
  rg_name = module.environment.resource_group_name
  staticsite_DNS = module.frontend.default_DNS_name
  DNS_name = module.DNS.name
}

module "v_net_link_DNS" {
  source = "./DNS_module/link_v_net"
  rg_name = module.environment.resource_group_name
  DNS_name = module.DNS.name
  env = var.environment
  vnet_id = module.vnet.id
  auto_registration = true
}
# module "public_ip_address_applicaiton_gateway" {
#   source = "./app_gatway_WAF/public_ip"
#   public_ip_name = "app_gatway"
#   rg_location = module.environment.resource_group_location
#   rg_name = module.environment.resource_group_name
# }

# module "application_gatway" {
#   source = "./app_gatway_WAF/applicaiton_gatway"
#   gatway_name = "${var.environment}-gs-gatway"
#   subnet_id = module.private_link_subnet.subnet_id
#   public_ip = module.public_ip_address_applicaiton_gateway.public_ip
#   rg_location = module.environment.resource_group_location
#   rg_name = module.environment.resource_group_name
# }

# module "sql_server" {
#   source = "./sql_module/sql_server"
#   sql_server_name = "${var.environment}-gsmain"
#   sql_username = "gsadmin"
#   sql_password = "admin@1234"
#   rg_name = module.environment.resource_group_name
#   rg_location = module.environment.resource_group_location
# }

# module "sql_database" {
#   source = "./sql_module/sql_database"
#   sql_db_name = "${var.environment}-pepsico"
#   sql_server_id = module.sql_server.sql_server_id
#   sql_sku = "S0"
#   geo_backup = true
#   env = var.environment
# }

# module "sql_firewall" {
#   source = "./sql_module/sql_firewall"
#   firewall_rule_name = "first"
#   sql_server_id = module.sql_server.sql_server_id
#   starting_from_ip = "0.0.0.0"
#   ending_ip = "255.255.255.255"
# }

