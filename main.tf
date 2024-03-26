terraform {
  backend "gcs" {
    bucket = "terraform-state-helloworld"
    prefix = "prod"
  }
}

provider "google" {
  project = var.project
  region = var.region
}

resource "google_cloud_run_service" "helloworld_app" {
  name = "helloworld-app"
  location = var.region
  template {
    spec {
      containers {
        image = "gcr.io/helloworld-418410/helloworld"
      }
    }
  }
}