output "app_external_ip" {
  value = "${google_compute_instance.app[*].netwтавил ork_interface[0].access_config[0].nat_ip}"
}

output "lb_ip" {
  value = google_compute_forwarding_rule.reddit-app-forwarding.ip_address
}
