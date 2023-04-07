resource "google_service_account" "gke" {
  account_id = "kubernetes-${var.deploy_env}-${var.region}"
  display_name = "gke-${var.deploy_env}-${var.region}"
}

resource "google_container_node_pool" "stateful" {
  name               = "stateful-${var.region}"
  cluster            = google_container_cluster.gke_masters.id
  initial_node_count = var.node_info.stateful["initial_node_count"]

  autoscaling {
    min_node_count = var.node_info.stateful["min_node_count"]
    max_node_count = var.node_info.stateful["max_node_count"]
  }

  lifecycle {
    ignore_changes = [
      initial_node_count
    ]
  }

  node_config {
    preemptible  = false
    machine_type = var.node_info.stateful["machine_type"]

    labels = {
      type = "stateful"
    }

    service_account = google_service_account.gke.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_container_node_pool" "spot" {
  name               = "spot-${var.region}"
  cluster            = google_container_cluster.gke_masters.id
  initial_node_count = var.node_info.spot["initial_node_count"]

  autoscaling {
    min_node_count = var.node_info.spot["min_node_count"]
    max_node_count = var.node_info.spot["max_node_count"]
  }

  lifecycle {
    ignore_changes = [
      initial_node_count
    ]
  }

  node_config {
    preemptible  = false
    machine_type = var.node_info.spot["machine_type"]

    labels = {
      type = "spot"
    }

    taint {
      key    = "instance_type"
      value  = "spot"
      effect = "NO_SCHEDULE"
    }

    service_account = google_service_account.gke.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
