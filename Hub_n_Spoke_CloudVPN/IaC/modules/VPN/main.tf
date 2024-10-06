############################## VPN Gateways ##############################
resource "google_compute_ha_vpn_gateway" "compute_ha_vpn_gateway" {
  name       = var.name
  project    = var.project
  region     = var.vpn_specs.region
  network    = var.network_id
  stack_type = var.vpn_specs.stack_type
}