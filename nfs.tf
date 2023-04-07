resource "google_filestore_instance" "nfs" {
  name = "${var.deploy_env}-nfs-${var.region}"
  location = "${var.region}-a"
  tier = var.nfs_info["tier"]

  file_shares {
    capacity_gb = var.nfs_info["capacity_gb"]
    name        = "share1"
  }

  networks {
    network           = google_compute_network.gke_vpc.name
    modes             = ["MODE_IPV4"]
    reserved_ip_range = google_compute_global_address.internal_managed_services.name
    connect_mode = "PRIVATE_SERVICE_ACCESS"
  }

  # Issue: https://github.com/hashicorp/terraform-provider-google/issues/12877
  lifecycle {
    ignore_changes = [
      networks[0].reserved_ip_range
    ]
  }

  depends_on = [
    google_service_networking_connection.internal_managed_services
  ]
}
