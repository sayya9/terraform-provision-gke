resource "google_compute_router_nat" "gke_nat" {
  name   = "${var.deploy_env}-nat-config"
  router = google_compute_router.gke_router.name
  region = "${var.region}"

  source_subnetwork_ip_ranges_to_nat  = "LIST_OF_SUBNETWORKS"
  nat_ip_allocate_option              = "MANUAL_ONLY"

  subnetwork {
    name                    = google_compute_subnetwork.gke_private.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  nat_ips = [
    google_compute_address.cloud_nat_address1.self_link,
    google_compute_address.cloud_nat_address2.self_link
  ]
}
