terraform {
  backend "gcs" {
    bucket = "helloworld-418410-terraform"
    prefix = "helloworld"
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

resource "google_cloud_run_service" "this" {
  name     = "helloworld-app"
  location = var.region
  template {
    spec {
      containers {
        image = "${var.region}-docker.pkg.dev/${var.project}/${var.repository}/${var.app_version}:latest"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "public" {
  service  = google_cloud_run_service.this.name
  location = google_cloud_run_service.this.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}