
# this is firerole for the vpc scope allow only the http
resource "google_compute_firewall" "http" {
  name    = "http-firewall"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}




# this is firerole to allow ssh from autanticate account from specific network (iap range ) to 
# prevent any one can access the vms exepect the authorized to route traffic securely
# to applications hosted on Compute Engine

resource "google_compute_firewall" "ssh" {
  name    = "ssh-firewall"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
}


