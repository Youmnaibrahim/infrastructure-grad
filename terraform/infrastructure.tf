
#i allow api like compute and container to make me work with vms and gke
resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}
resource "google_project_service" "container" {
  service = "container.googleapis.com"
}




# i create vpc depends on creating the previous api 
resource "google_compute_network" "vpc_network" {
  project                 = "sincere-hearth-377212"
  name                    = "mynewvpc"
  auto_create_subnetworks = false
  depends_on = [
    google_project_service.compute,
    google_project_service.container
  ]
}



#then i create public mangment subnet and i make it bublic to put the natgateway in it to active it
resource "google_compute_subnetwork" "mangmentsubnet" {
  name          = "mangmentsubnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = "asia-east1"
  network       = google_compute_network.vpc_network.id
  
  }



#icreate restricted subnet (private) to prevent any one to access my cluster 
#so any vm will create in this subnet will not take any public ip address 

resource "google_compute_subnetwork" "restrictedsubnet" {
  name          = "restrictedsubnet"
  ip_cidr_range = "10.0.3.0/24"
  region        = "asia-east1"
  network       = google_compute_network.vpc_network.id
  private_ip_google_access = true
  }

