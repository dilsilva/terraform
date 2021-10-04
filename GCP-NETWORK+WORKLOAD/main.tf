# *Main Providers and pre-requisites

data "google_client_config" "default" {}

data "google_project" "project" {
  provider = google-beta
}

terraform {
  required_version = ">= 1.0"
  required_providers {

    google-beta = "~> 3.82" # https://github.com/terraform-providers/terraform-provider-google/releases
    google      = "~> 3.82" # https://github.com/terraform-providers/terraform-provider-google-beta/releases
    random      = "~> 3.1"  # https://github.com/hashicorp/terraform-provider-random/releases
  }
}

provider "google-beta" {
  credentials = var.gcp_credentials_json
  project     = var.gcp_project_id
  region      = var.region
  zone        = var.zone
}

provider "google" {

  credentials = var.gcp_credentials_json
  project     = var.gcp_project_id
  region      = var.region
  zone        = var.zone
}

## -> GCP APIs to enable services.
resource "google_project_service" "apis" {
  for_each           = local.apis_gcp
  service            = each.value
  project            = var.gcp_project_id
  disable_on_destroy = false
}
