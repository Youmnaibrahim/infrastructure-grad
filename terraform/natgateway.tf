
#this is a router and i specifiy it in specific region where managment subnet exist (public subnet)

resource "google_compute_router" "router-nat" {
  name    = "my-router"
  region  = google_compute_subnetwork.mangmentsubnet.region
  network = google_compute_network.vpc_network.id
}



# this allow the natgateway to work with all subnet like mangment subnet and restreicted subnet because 
# i have private cluster in the restrected subnet and private vm in the mangment subnet 
resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.router-nat.name
  region                             = google_compute_router.router-nat.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

}

