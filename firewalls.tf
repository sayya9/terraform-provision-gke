resource "google_compute_firewall" "only_internal_traffic" {
  name    = "only-internal-traffic"
  network = google_compute_network.gke_vpc.name

  allow {
    protocol = "all"
  }

  source_ranges = ["10.0.0.0/8"]
}

resource "google_compute_firewall" "master_webhooks" {
  name    = "gke-allow-master-webhooks"
  network = google_compute_network.gke_vpc.name

  allow {
    protocol = "tcp"
    ports = ["443", "8443"]
  }

  source_ranges = ["172.16.0.0/28"]
}
