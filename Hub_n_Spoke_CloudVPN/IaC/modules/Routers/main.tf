############################## Routers ##############################
resource "google_compute_router" "compute_router" {
  name    = var.name    #"router-hub-${var.abr_region_A}-prd-001"
  project = var.project #data.google_project.project.project_id
  region  = var.router_specs.region
  network = var.network_id

  bgp {
    advertise_mode     = var.router_specs.bgp.advertise_mode #"CUSTOM"
    asn                = var.router_specs.bgp.asn
    keepalive_interval = var.router_specs.bgp.keepalive_interval #20

    advertised_ip_ranges {
      range = var.router_specs.bgp.advertised_ip_ranges.range #"0.0.0.0/0"
    }
  }
}