terraform {
  # Версия terraform
  required_version = "0.12.8"
}

provider "google" {
  # Версия провайдера
  version = "2.15.0"
  project = var.project
  region  = var.region
}

resource "google_compute_instance" "app" {
  name         = "${var.app_name}-${count.index}"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["reddit-app"]
  count = var.count_of_applications

  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }
  metadata = {
    # путь до публичного ключа
    ssh-keys = "nluzgin:${file(var.public_key_path)}"
  }

  network_interface {
    network = "default"
    access_config {}
  }

  provisioner "file" {
    source      = "/home/user/Documents/OTUS/nluzgin_infra/terraform/files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }

  connection {
    type  = "ssh"
    host  = self.network_interface[0].access_config[0].nat_ip
    user  = "nluzgin"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }
}

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
  source_ranges = ["0.0.0.0/0"]

  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["reddit-app"]
}


resource "google_compute_project_metadata" "ssh-keys" {
  metadata = {
    ssh-keys = "appuser1:${file(var.public_key_path)} appuser2:${file(var.public_key_path)}"
  }
}
