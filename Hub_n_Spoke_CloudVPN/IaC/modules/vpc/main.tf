############################## VPC ##############################
resource "google_compute_network" "compute_network" {
  name                                      = var.vpc_name
  project                                   = var.project
  auto_create_subnetworks                   = var.vpc_specs.auto_create_subnetworks
  mtu                                       = var.vpc_specs.mtu
  network_firewall_policy_enforcement_order = var.vpc_specs.network_firewall_policy_enforcement_order
  routing_mode                              = var.vpc_specs.routing_mode
}

############################## Subnets ##############################
resource "google_compute_subnetwork" "compute_subnetwork" {
  for_each                   = var.vpc_specs.subnet_specs
  name                       = each.key
  project                    = var.project
  region                     = each.value.region
  network                    = google_compute_network.compute_network.id
  ip_cidr_range              = each.value.ip_cidr_range
  private_ip_google_access   = each.value.private_ip_google_access
  private_ipv6_google_access = each.value.private_ipv6_google_access
  purpose                    = each.value.purpose
  stack_type                 = each.value.stack_type

  log_config {
    metadata      = "INCLUDE_ALL_METADATA"
    flow_sampling = 1
  }
}

############################## Firewall Rules ##############################
resource "google_compute_firewall" "compute_firewall" {
  for_each      = var.vpc_specs.firewall_specs
  name          = "allow-all-traffic-${var.vpc_abr}"
  project       = var.project
  network       = google_compute_network.compute_network.id
  direction     = each.value.direction
  priority      = each.value.priority
  source_ranges = each.value.source_ranges

  allow {
    protocol = each.value.allow.protocol
  }

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}


