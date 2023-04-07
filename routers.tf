resource "google_compute_router" "gke_router" {
  name    = "${var.deploy_env}-nat-router"
  region  = "${var.region}"
  network = google_compute_network.gke_vpc.id
}
