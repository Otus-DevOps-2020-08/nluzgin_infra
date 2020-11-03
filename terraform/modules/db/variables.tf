variable public_key_path {
  # Описание переменной
  description = "Path to the public key used to connect to instance"
}

variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "europe-west1-b"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default = "reddit-base-db-1595787464"
}
