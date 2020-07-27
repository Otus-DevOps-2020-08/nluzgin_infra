output "app_external_ip" {
  value = module.app
}

output "db_ip" {
  value = module.db.db_ip
}
