resource "google_compute_instance" "private-vm" {
  name         = "private-vm"
  machine_type = "e2-medium"
  zone         = "asia-east1-a"

  
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
        }
    }
  


  network_interface {
    subnetwork = google_compute_subnetwork.mangmentsubnet.id
  }
   
 
  metadata_startup_script = file("script.sh")

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.vm-service-account.email
    scopes = ["cloud-platform"]
  }
}