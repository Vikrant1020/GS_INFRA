# output "sql_server_admin_user" {
#   value = module.sql_server.sql_admin_user
# }

# output "sql_server_admin_password" {
#   value = module.sql_server.sql_admin_password
# }

output "private_endpoint_ip" {
  value = module.endpoint_frontend.ip
}