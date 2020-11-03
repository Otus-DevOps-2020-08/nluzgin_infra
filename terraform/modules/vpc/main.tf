resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"

  # Название сети, в которой действует правило

  network = "default"

  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  # Каким адресам разрешаем доступ
  source_ranges = var.source_ranges

  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["reddit-app"]
}

resource "google_compute_firewall" "firewall_mongo" {
  name = "default-mongo"
  network = "default"
  allow {
    protocol = "tcp"
    ports = ["27017"]
  }
  target_tags = ["reddit-db"]
  source_tags = ["reddit-app"]
  source_ranges = var.source_ranges
}

resource "google_compute_firewall" "firewall_ssh" {
  name = "default-allow-ssh"
  network = "default"
  allow {
   protocol = "tcp"
    ports = ["22"]
  }
  source_ranges = var.source_ranges
}

resource "google_compute_firewall" "firewall_http_80" {
  name = "allow-http-80"
  network = "default"
  allow {
   protocol = "tcp"
    ports = ["80"]
  }
  source_ranges = var.source_ranges
  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["reddit-app"]
}
