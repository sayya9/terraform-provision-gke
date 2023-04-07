resource "google_project_service" "servicenetworking" {
  service = "servicenetworking.googleapis.com"
}

resource "google_compute_global_address" "internal_managed_services" {
  name          = "internal-managed-services-${var.region}"
  provider      = google-beta

  address       = split("/", "${var.internal_managed_services_cidr}")[0]
  address_type  = "INTERNAL"
  network       = google_compute_network.gke_vpc.self_link
  prefix_length = split("/", "${var.internal_managed_services_cidr}")[1]
  project       = "${var.project_id}"
  purpose       = "VPC_PEERING"
}

resource "google_service_networking_connection" "internal_managed_services" {
  network                 = google_compute_network.gke_vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.internal_managed_services.name]

  depends_on = [
    google_project_service.servicenetworking
  ]
}
