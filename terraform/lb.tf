resource "google_compute_target_pool" "reddit-app-pool" {
  name = "reddit-app-pool"
  instances = google_compute_instance.app[*].self_link
  health_checks = [
    google_compute_http_health_check.reddit-app-pool_hc.name,
  ]
}

resource "google_compute_http_health_check" "reddit-app-pool_hc" {
  name               = "reddit-app-pool-hc"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
  host               = "34.78.86.202"
  port               = var.port
}

resource "google_compute_forwarding_rule" "reddit-app-forwarding" {
  name       = "reddit-app-forwarding"
  target     = google_compute_target_pool.reddit-app-pool.self_link
  port_range = var.port
}