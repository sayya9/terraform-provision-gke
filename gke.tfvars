project_id = "project_id"
region = "asia-east1"
deploy_env = "test"
gke_vpc_cidr = "10.111.0.0/18"
pod_cidr = "10.111.64.0/18"
service_cidr = "10.111.128.0/18"
internal_managed_services_cidr = "10.111.192.0/24"
redis_memory_size = 1
node_info = {
  stateful = {
    initial_node_count = 1
    min_node_count     = 1
    max_node_count     = 3
    machine_type       = "e2-standard-2"
  }
  spot = {
    initial_node_count = 1
    min_node_count     = 1
    max_node_count     = 10
    machine_type       = "n1-standard-1"
  }
}
nfs_info = {
  tier = "STANDARD"
  capacity_gb = 1024
}
