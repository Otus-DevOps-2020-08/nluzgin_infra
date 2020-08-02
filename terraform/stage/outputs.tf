output "app_external_ip" {
  value = module.app.app_external_ip[0]
}

output "db_ip" {
  value = module.db.db_ip[0]
}
