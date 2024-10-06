resource "google_network_connectivity_policy_based_route" "network_connectivity_policy_based_route" {
  name            = var.name                               #"pbr-hub-${var.abr_region_A}-prd"
  project         = var.project                            #data.google_project.project.project_id
  priority        = var.policy_based_routes_specs.priority #100
  network         = var.network_id                         #google_compute_network.compute_network.id
  next_hop_ilb_ip = var.next_hop_ilb_ip                    #google_compute_address.compute_address_region_A.address

  filter {
    protocol_version = var.policy_based_routes_specs.filter.protocol_version #"IPV4"
    ip_protocol      = var.policy_based_routes_specs.filter.ip_protocol      #"ALL"
    src_range        = var.policy_based_routes_specs.filter.src_range        #"0.0.0.0/0"
    dest_range       = var.policy_based_routes_specs.filter.dest_range       #"infras supernet"
  }
}


resource "google_network_connectivity_policy_based_route" "network_connectivity_policy_based_route_skip" {
  name                  = var.name_skip                               #"pbr-skip-hub-${var.abr_region_A}-prd"
  project               = var.project                                 #data.google_project.project.project_id
  priority              = var.skip_policy_based_routes_specs.priority #10
  network               = var.network_id                              #google_compute_network.compute_network.id
  next_hop_other_routes = "DEFAULT_ROUTING"

  filter {
    protocol_version = var.skip_policy_based_routes_specs.filter.protocol_version #"IPV4"
    ip_protocol      = var.skip_policy_based_routes_specs.filter.ip_protocol      #"ALL"
    src_range        = var.skip_policy_based_routes_specs.filter.src_range        #"0.0.0.0/0"
    dest_range       = var.skip_policy_based_routes_specs.filter.dest_range       #"infras supernet"
  }

  virtual_machine {
    tags = var.tags
  }
}