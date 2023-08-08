resource "google_container_cluster" "shaped-cluster" {
  name     = "shaped-cluster-${var.environment}"
  location = var.region

  network    = google_compute_network.gke-vpc.name
  subnetwork = google_compute_subnetwork.gke-subnet.name

  remove_default_node_pool = true # This is a recommended practice, without this, you would need to 
  initial_node_count       = 1    # recreate the cluster if you wanted to add/remove nodes
}

resource "google_container_node_pool" "cluster-nodes" {
  name       = "node-pool-${var.environment}"
  location   = var.region
  cluster    = google_container_cluster.shaped-cluster.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    service_account = var.service-account-email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
 
# Seperate node group here for GPUs. Allows us to only provision this group when needed
# commenting out because Google doesn't want to let me deploy gpu nodes :(
# resource "google_container_node_pool" "gpu-nodes" {
#   name       = "gpu-node-pool-${var.environment}"
#   location   = var.region
#   cluster    = google_container_cluster.shaped-cluster.name
#   node_count = 1

#   node_config {
#     preemptible  = false # False here to get over the quota limits
#     machine_type = "n1-standard-4"

#     guest_accelerator {
#       count = 1
#       type  = "nvidia-tesla-t4" 
#     }

#     labels = {
#       gpu-node = "true" # We label the node here so we can target it with Argo 
#     }

#     service_account = var.service-account-email
#     oauth_scopes = [
#       "https://www.googleapis.com/auth/cloud-platform"
#     ]
#   }
# }

resource "kubernetes_namespace" "argo_namespace" { # needed for argo installation
  metadata {
    name = "argo"
  }
}