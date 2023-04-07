resource "google_compute_firewall" "only_internal_traffic" {
  name    = "only-internal-traffic"
  network = google_compute_network.gke_vpc.name

  allow {
    protocol = "all"
  }

  source_ranges = ["10.0.0.0/8"]
}
