resource "google_compute_network" "gke-vpc" {
  project = var.project_name
  name    = "vpc-${var.environment}"
}

resource "google_compute_subnetwork" "gke-subnet" {
  name          = "gke-subnet-${var.environment}"
  region        = var.region
  network       = google_compute_network.gke-vpc.self_link
  ip_cidr_range = "10.0.120.0/24"
}

resource "google_compute_firewall" "allow-gke-api" {
  name          = "allow-gke-api-${var.environment}"
  network       = google_compute_network.gke-vpc.self_link
  source_ranges = [var.whitelist_ip]

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
}