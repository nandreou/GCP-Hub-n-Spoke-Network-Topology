############################## Routers ##############################
resource "google_compute_router" "compute_router" {
  name    = var.name
  project = var.project
  region  = var.router_specs.region
  network = var.network_id

  bgp {
    advertise_mode     = var.router_specs.bgp.advertise_mode
    asn                = var.router_specs.bgp.asn
    keepalive_interval = var.router_specs.bgp.keepalive_interval

    advertised_ip_ranges {
      range = var.router_specs.bgp.advertised_ip_ranges.range
    }
  }
}