variable "router_name" {
  type = string
}

variable "cloud_nat_name" {
  type = string
}

variable "region" {
  type = string
}

variable "project" {
  type = string
}

variable "network_id" {
  type = string
}

variable "compute_router_nat_specs" {
  type = object({
    nat_ip_allocate_option             = string
    source_subnetwork_ip_ranges_to_nat = string
  })
}