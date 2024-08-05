output "endpoint_fqdn" {
  value = { for ep in azurerm_private_endpoint.main : ep.name =>
    coalesce(one(flatten([for config in ep.private_dns_zone_configs :
  [for record_set in config.record_sets : record_set.fqdn]])), "NOT PRESET") }
}
