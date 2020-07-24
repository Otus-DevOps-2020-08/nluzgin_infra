terraform {
  # Версия terraform
  required_version = "0.12.19"
}

provider "google" {
  # Версия провайдера
  version = "2.15.0"
  project = var.project
  region  = var.region
}

module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  zone            = var.zone
  db_disk_image   = var.db_disk_image
}

module "app" {
  source          = "../modules/app"
  public_key_path = var.public_key_path
  zone            = var.zone
  app_disk_image  = var.app_disk_image
  private_key_path = var.private_key_path
  db_ip = "${module.db.db_ip[0]}:27017"
}

module "vpc" {
  source = "../modules/vpc"
}
