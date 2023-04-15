resource "google_container_cluster" "gke_masters" {
  name                     = "devops-demo-gke"
  location                 = "${var.region}"
  min_master_version       = "1.24"
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.gke_vpc.self_link
  subnetwork               = google_compute_subnetwork.gke_private.self_link
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  networking_mode          = "VPC_NATIVE"

  node_locations = [
    "${var.region}-a",
    "${var.region}-b"
  ]

  addons_config {
    http_load_balancing {
      disabled = false
    }

    horizontal_pod_autoscaling {
      disabled = false
    }

    network_policy_config {
      disabled = false
    }
  }

  network_policy {
    provider = "CALICO"
    enabled = true
  }

  release_channel {
    channel = "STABLE"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  master_authorized_networks_config {
    # cidr_blocks {
    #   cidr_block   = "1.2.3.4/32"
    #   display_name = "jenkins"
    # }

    # cidr_blocks {
    #   cidr_block   = "5.6.7.8/32"
    #   display_name = "andrew"
    # }
  }
}
