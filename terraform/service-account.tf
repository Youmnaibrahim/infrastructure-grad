
#service account that i shoud attach it to my vm
resource "google_service_account" "vm-service-account" {
  account_id   = "vm-service-account"
  display_name = "vm-service-account"
}


#role for service account to allow the vm to talk with the gke to do any thing in it like kubectl . 

resource "google_project_iam_member" "vm-role" {
  project = "sincere-hearth-377212"
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.vm-service-account.email}"
}






#service account number 2 for gke 
resource "google_service_account" "gke-service-account" {
  account_id   = "gke-service-account"
  display_name = "gke-service-account"
}



#rules for service account two 
resource "google_project_iam_member" "gke-role-1" {
  project = "sincere-hearth-377212"
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.gke-service-account.email}"
}


resource "google_project_iam_member" "gke-role-2" {
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.gke-service-account.email}"
  project = "sincere-hearth-377212"
}


resource "google_project_iam_member" "gke-role-3" {
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${google_service_account.gke-service-account.email}"
  project = "sincere-hearth-377212"
}

