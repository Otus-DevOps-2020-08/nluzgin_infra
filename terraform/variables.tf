variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  # Значение по умолчанию
  default = "europe-west1"
}

variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  # Описание переменной
  description = "Path to the private key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "europe-west1-b"
}

variable app_name {
  description = "name"
  # Значение по умолчанию
  default = "reddit-app-by-terraform"
}

variable port {
  description = "port"
  # Значение по умолчанию
  default = "9292"
}

variable count_of_applications {
  description = "port"
  # Значение по умолчанию
  default = 2
}
