module "devops" {
    source = "./devops_module"
    azuredevops_name = var.devops_project
    github_token = var.github_token
    rg_location = "East US"
    rg_name = "greensight-dev-rg"
}

# module "pipeline" {
#     source = "./pipeline_module/frontend"
#     name = "${var.pre-fix}-frontend"
#     github_repo = var.github_repo
#     github_branch = var.github_branch
#     ymlpath = var.ymlpath
#     github_service_connection = module.devops.github_service_connection
#     project_id = module.devops.devops_project
#     web_app_token = module.frontend.web_app_token
#     depends_on = [
#     module.devops , module.frontend
#   ]
# }

# module "frontend" {
#   source = "./static_web_module"
#   resource_group_name = module.devops.resource_group_name
#   web_app_name = "${var.pre-fix}-frontend"
#   env = "dev"
# }

# module "vnet" {
#   source = "./v_net_module/v_net"
#   v_net_name = "${var.pre-fix}-main"
#   rg_location = module.devops.resource_group_location
#   rg_name = module.devops.resource_group_name
#   cidr_v_net = "10.0.0.0/16"
# }

# module "subnet1" {
#   source = "./v_net_module/subnet"
#   subnet_name = "${var.pre-fix}-main"
#   rg_name = module.devops.resource_group_name
#   subnet_cidr = "10.0.1.0/24"
#   v_net_name = module.vnet.v_net_name
# }

# module "subnet2" {
#   source = "./v_net_module/subnet"
#   subnet_name = "${var.pre-fix}-master"
#   rg_name = module.devops.resource_group_name
#   subnet_cidr = "10.0.3.0/24"
#   v_net_name = module.vnet.v_net_name
# }

# module "endpoint_frontend" {
#   source = "./endpoint_module"
#   name = "${var.pre-fix}-gs-test1"
#   rg_location = module.devops.resource_group_location
#   rg_name = module.devops.resource_group_name
#   subnet_id = module.subnet1.subnet_id
#   link_name = "${var.pre-fix}-frontend-ep"
#   pe_resource_id = module.frontend.id
#   env = var.pre-fix
#   # subresource_names = "staticSites"
#   depends_on = [
#     module.devops , module.subnet1 , module.frontend
#   ]
# }

module "storage" {
  source = "./storage_module/storage_account"
  storage_name = "${var.pre-fix}greensight"
  env = var.pre-fix
  rg_name = module.devops.resource_group_name
  rg_location = module.devops.resource_group_location
}

module "container1" {
  source = "./storage_module/container"
  storage_name = module.storage.storage_account_name
  container_name = var.container_name
}

module "lifecycle" {
  source = "./storage_module/lifecycleyule"
  container_name = module.container1.name
  storage_account_id = module.storage.storage_account_id
  rule_enable = true
  time_to_move_to_cool = 14
  time_to_move_to_archive = 90
}