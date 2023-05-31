resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"
}

resource "google_compute_network" "gke_vpc" {
  name                            = "${var.deploy_env}-network"
  routing_mode                    = "REGIONAL"
  auto_create_subnetworks         = false
  mtu                             = 1460
  delete_default_routes_on_create = false

  depends_on = [
    google_project_service.compute,
    google_project_service.container
  ]
}

resource "google_compute_subnetwork" "gke_private" {
  name                     = "${var.deploy_env}-subnet-${var.region}"
  ip_cidr_range            = var.gke_vpc_cidr
  region                   = "${var.region}"
  network                  = google_compute_network.gke_vpc.id
  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_30_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }

  secondary_ip_range {
    range_name    = "k8s-pod-range"
    ip_cidr_range = var.pod_cidr
  }
  secondary_ip_range {
    range_name    = "k8s-service-range"
    ip_cidr_range = var.service_cidr
  }
}
