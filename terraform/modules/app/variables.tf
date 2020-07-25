variable public_key_path {
  # Описание переменной
  description = "Path to the public key used to connect to instance"
}

variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "europe-west1-b"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default = "reddit-base-app-1594739783"
}

variable private_key_path {
  # Описание переменной
  description = "Path to the private key used for ssh access"
}

variable db_ip {
  # Описание переменной
  description = "Mongo IP"
}

variable deploy_script_path {
  # Описание переменной
  description = "scropt path"
  default = "/tmp/deploy.sh"
}

variable puma_service_path {
  # Описание переменной
  description = "puma.service path"
  default = "/tmp/puma.service"
}
