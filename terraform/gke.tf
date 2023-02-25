
#this is master palne
resource "google_container_cluster" "cluster" {
  name       = "my-private-cluster"
  project    = "sincere-hearth-377212"
  location   = "asia-east1-a"
  network    = google_compute_network.vpc_network.id
  subnetwork = google_compute_subnetwork.restrictedsubnet.id
  remove_default_node_pool = true
  initial_node_count = 1
  ip_allocation_policy {

  }
    private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }
  master_authorized_networks_config {
    cidr_blocks {
      display_name = "mangmentsubnet"
      cidr_block = "10.0.0.0/24"
    }
    cidr_blocks {
      display_name = "restrictedsubnet"
      cidr_block = "10.0.3.0/24"
    }
  }
}



#this is for worker node 

resource "google_container_node_pool" "worker-node" {
  name       = "my-worker-node"
  location   = "asia-east1-a"
  cluster    = google_container_cluster.cluster.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-standard-4"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.gke-service-account.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}