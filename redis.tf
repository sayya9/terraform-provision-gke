resource "google_project_service" "redis" {
  service = "redis.googleapis.com"

  disable_dependent_services = true
  disable_on_destroy         = false
}

resource "google_redis_instance" "redis" {
  name           = "${var.deploy_env}-redis-${var.region}"
  tier           = "BASIC"
  memory_size_gb = "${var.redis_memory_size}"
  region         = "${var.region}"
  redis_version  = "REDIS_6_X"

  authorized_network = google_compute_network.gke_vpc.id
  connect_mode       = "PRIVATE_SERVICE_ACCESS"

  depends_on = [
    google_service_networking_connection.internal_managed_services,
    google_project_service.redis
  ]
}
