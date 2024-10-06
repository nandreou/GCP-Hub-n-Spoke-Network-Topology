############################## VPC ##############################
resource "google_compute_network" "compute_network" {
  name                                      = var.vpc_name                                            #"vpc-hub-prd-001"
  project                                   = var.project                                             #data.google_project.project.project_id
  auto_create_subnetworks                   = var.vpc_specs.auto_create_subnetworks                   #false
  mtu                                       = var.vpc_specs.mtu                                       #1460
  network_firewall_policy_enforcement_order = var.vpc_specs.network_firewall_policy_enforcement_order #"AFTER_CLASSIC_FIREWALL"
  routing_mode                              = var.vpc_specs.routing_mode                              #"GLOBAL"
  delete_default_routes_on_create           = var.vpc_specs.delete_default_routes_on_create           #true
}

############################## Subnets ##############################
resource "google_compute_subnetwork" "compute_subnetwork" {
  for_each                   = var.vpc_specs.subnet_specs
  name                       = "snet-${strcontains(var.vpc_abr, "mgmt") ? "mgmt" : var.vpc_abr}-${each.value.region == "europe-west4" ? "ams" : "fra"}-prd-${each.value.name_index}"
  project                    = var.project
  region                     = each.value.region
  network                    = google_compute_network.compute_network.id
  ip_cidr_range              = each.value.ip_cidr_range
  private_ip_google_access   = each.value.private_ip_google_access   #true
  private_ipv6_google_access = each.value.private_ipv6_google_access #"DISABLE_GOOGLE_ACCESS"
  purpose                    = each.value.purpose                    #"PRIVATE"
  stack_type                 = each.value.stack_type                 #"IPV4_ONLY"

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
  direction     = each.value.direction     #"INGRESS"
  priority      = each.value.priority      #100
  source_ranges = each.value.source_ranges #["0.0.0.0/0"]

  allow {
    protocol = each.value.allow.protocol #"all"
  }

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}


