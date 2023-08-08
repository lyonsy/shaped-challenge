provider "google" {
  project     = "shaped-challenge"
  region      = "us-central1"
  zone        = "us-central1-c"
  credentials = file("../credentials.json")
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}