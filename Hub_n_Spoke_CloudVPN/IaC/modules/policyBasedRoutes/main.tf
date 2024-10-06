resource "google_network_connectivity_policy_based_route" "network_connectivity_policy_based_route" {
  name            = var.name
  project         = var.project
  priority        = var.policy_based_routes_specs.priority
  network         = var.network_id
  next_hop_ilb_ip = var.next_hop_ilb_ip

  filter {
    protocol_version = var.policy_based_routes_specs.filter.protocol_version
    ip_protocol      = var.policy_based_routes_specs.filter.ip_protocol
    src_range        = var.policy_based_routes_specs.filter.src_range
    dest_range       = var.policy_based_routes_specs.filter.dest_range
  }
}


resource "google_network_connectivity_policy_based_route" "network_connectivity_policy_based_route_skip" {
  name                  = var.name_skip
  project               = var.project
  priority              = var.skip_policy_based_routes_specs.priority
  network               = var.network_id
  next_hop_other_routes = "DEFAULT_ROUTING"

  filter {
    protocol_version = var.skip_policy_based_routes_specs.filter.protocol_version
    ip_protocol      = var.skip_policy_based_routes_specs.filter.ip_protocol
    src_range        = var.skip_policy_based_routes_specs.filter.src_range
    dest_range       = var.skip_policy_based_routes_specs.filter.dest_range
  }

  virtual_machine {
    tags = var.tags
  }
}