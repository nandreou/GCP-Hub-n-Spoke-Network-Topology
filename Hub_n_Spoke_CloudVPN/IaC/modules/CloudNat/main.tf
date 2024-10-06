resource "google_compute_router" "compute_router" {
  name    = var.router_name
  region  = var.region
  project = var.project
  network = var.network_id
}

resource "google_compute_router_nat" "compute_router_nat" {
  name                               = var.cloud_nat_name
  project                            = var.project
  region                             = var.region
  router                             = google_compute_router.compute_router.name
  nat_ip_allocate_option             = var.compute_router_nat_specs.nat_ip_allocate_option
  source_subnetwork_ip_ranges_to_nat = var.compute_router_nat_specs.source_subnetwork_ip_ranges_to_nat

  log_config {
    enable = true
    filter = "ALL"
  }
}