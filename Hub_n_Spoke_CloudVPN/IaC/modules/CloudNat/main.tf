resource "google_compute_router" "compute_router" {
  name    = var.router_name #"nat-router"
  region  = var.region
  project = var.project
  network = var.network_id #"my-custom-network-2"
}

resource "google_compute_router_nat" "compute_router_nat" {
  name                               = var.cloud_nat_name #"my-router-nat"
  project                            = var.project
  region                             = var.region
  router                             = google_compute_router.compute_router.name
  nat_ip_allocate_option             = var.compute_router_nat_specs.nat_ip_allocate_option             #"AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = var.compute_router_nat_specs.source_subnetwork_ip_ranges_to_nat #"ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ALL"
  }
}