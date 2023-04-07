resource "google_compute_address" "cloud_nat_address1" {
  name         = "${var.deploy_env}-cloud-nat1"
  address_type = "EXTERNAL"
  project      = "${var.project_id}"
  network_tier = "PREMIUM"
  region       = "${var.region}"

  depends_on   = [
    google_project_service.compute
  ]
}

resource "google_compute_address" "cloud_nat_address2" {
  name         = "${var.deploy_env}-cloud-nat2"
  address_type = "EXTERNAL"
  project      = "${var.project_id}"
  network_tier = "PREMIUM"
  region       = "${var.region}"

  depends_on   = [
    google_project_service.compute
  ]
}
