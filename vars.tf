variable "project_id" {
  type    = string
  default = ""
}

variable "region" {
  type    = string
  default = ""
}

variable "deploy_env" {
  type    = string
  default = ""
}

variable "gke_vpc_cidr" {
  type    = string
  default = ""
}

variable "pod_cidr" {
  type    = string
  default = ""
}

variable "service_cidr" {
  type    = string
  default = ""
}

variable "internal_managed_services_cidr" {
  type    = string
  default = ""
}

variable "redis_memory_size" {
  type    = number
  default = null
}

variable "node_info" {
  type    = map
  default = {}
}

variable "nfs_info" {
  type    = map
  default = {}
}
