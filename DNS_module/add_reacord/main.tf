resource "azurerm_private_dns_a_record" "example" {
  name                = var.staticsite_DNS
  zone_name           = var.DNS_name
  resource_group_name = var.rg_name
  ttl                 = 300
  records             = [var.private_ip]

}