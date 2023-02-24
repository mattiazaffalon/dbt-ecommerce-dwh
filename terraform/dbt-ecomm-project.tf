provider "google" {
  credentials = file("${var.credentials_file}")
  project     = var.project_id
  region      = var.region
}

resource "google_project_service" "project" {
  service = "bigquery.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "dbt_ecommerce"
  friendly_name               = "dbt_ecommerce"
  description                 = "Dev dataset"
  location                    = var.region
  default_table_expiration_ms = 3600000
  default_partition_expiration_ms = 5184000000

  labels = {
    env = "dev"
  }
}

resource "google_storage_bucket" "dbt-ecommerce-raw" {
  name          = "dbt-ecommerce-raw"
  location      = var.region
  force_destroy = true

  uniform_bucket_level_access = true
}

resource "google_service_account" "ecomm-dev-local" {
  account_id   = "ecomm-dev-local"
  display_name = "SA to be used to launch pipeline from the local environment"
}

resource "google_project_iam_member" "bigquery_editor" {
  project = var.project_id
  role    = "roles/bigquery.admin"
  member  = "serviceAccount:${google_service_account.ecomm-dev-local.email}"
}

resource "google_project_iam_member" "storage_admin" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.ecomm-dev-local.email}"
}

