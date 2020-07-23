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
