terraform {
  required_providers {
    firebase = {
      source  = "terraform-google-modules/firebase/google"
      version = "3.6.0"
    }
  }
}

provider "google" {
  credentials = file("/src/bus_tracking_system/service-acc-key.txt")
}

resource "google_project_service" "firebase" {
  project = var.project_id
  service = "firebase.googleapis.com"
}

resource "firebase_project" "BusTrackingSystem" {
  project = var.project_id
}

resource "firebase_database_instance" "my_database" {
  project      = var.project_id
  database     = "BusTrackingSystem"
  depends_on   = [google_project_service.firebase]
}

output "database_url" {
  value = firebase_database_instance.my_database.database_url
}
