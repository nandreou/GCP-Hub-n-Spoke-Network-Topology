############################## VPCs ##############################
module "networks" {
  source    = "./modules/vpc"
  for_each  = var.vpc_specs
  vpc_name  = "vpc-${each.key}-${each.value.name_index}"
  project   = var.project_ID
  vpc_abr   = each.key
  vpc_specs = each.value
}


module "VPN" {
  source     = "./modules/VPN"
  for_each   = var.vpn_specs
  name       = each.key
  project    = var.project_ID
  network_id = module.networks[each.value.vpc].vpc.id
  vpn_specs  = each.value
}


module "routers" {
  source       = "./modules/Routers"
  for_each     = var.router_specs
  name         = each.key
  project      = var.project_ID
  network_id   = module.networks[each.value.vpc].vpc.id
  router_specs = each.value
}

############################## Tags ##############################
module "tags" {
  source    = "./modules/tags"
  for_each  = var.tag_specs
  vpc_name  = module.networks[each.value.vpc].vpc.name
  project   = var.project_ID
  tag_specs = each.value
}

####################### LOAD BALANCER #######################
module "external_load_balancer" {
  source   = "./modules/loadBalancer/externalLoadBalancer"
  for_each = var.external_load_balancer_specs

  compute_address_name = "eip-${each.key}-${each.value.compute_address_specs.name_index}"
  health_check_name    = "health-check-${each.key}"
  backend_service_name = "nlbi-${each.key}-${each.value.lb_backend_specs.name_index}"
  forwarding_rule_name = "fwdrule-${each.key}-${each.value.lb_forwarding_rule_specs.name_index}"

  instance_group = "" #each.value.region == "europe-west4" ? google_compute_instance_group_manager.compute_instance_group_manager_region_A.instance_group : google_compute_instance_group_manager.compute_instance_group_manager_region_B.instance_group

  project = var.project_ID
  region  = each.value.region

  compute_address_specs    = each.value.compute_address_specs
  lb_health_check_specs    = each.value.lb_health_check_specs
  lb_backend_specs         = each.value.lb_backend_specs
  lb_forwarding_rule_specs = each.value.lb_forwarding_rule_specs

}

module "internal_load_balancer" {
  source   = "./modules/loadBalancer/internalLoadBalancer"
  for_each = var.internal_load_balancer_specs

  compute_address_name = "ip-${each.key}-${each.value.compute_address_specs.name_index}"
  health_check_name    = "health-check-${each.key}"
  backend_service_name = "nlbi-${each.key}-${each.value.lb_backend_specs.name_index}"
  forwarding_rule_name = "fwdrule-${each.key}-${each.value.lb_forwarding_rule_specs.name_index}"

  instance_group = ""

  project = var.project_ID
  region  = each.value.region

  network_id    = module.networks[each.value.vpc].vpc.id
  subnetwork_id = module.networks[each.value.vpc].subnets[each.value.subnet].id

  compute_address_specs    = each.value.compute_address_specs
  lb_health_check_specs    = each.value.lb_health_check_specs
  lb_backend_specs         = each.value.lb_backend_specs
  lb_forwarding_rule_specs = each.value.lb_forwarding_rule_specs

}

############################# ROUTES ##############################
module "policy_based_routes" {
  source   = "./modules/policyBasedRoutes"
  for_each = var.pbr_specs

  name      = "${each.key}-prd"
  name_skip = "skip-${each.key}-prd"

  project = var.project_ID

  network_id                     = module.networks[each.value.vpc].vpc.id
  next_hop_ilb_ip                = module.internal_load_balancer[each.value.policy_based_routes_specs.load_balancer].lb_address
  tags                           = [for i in module.tags : i.tag_key]
  policy_based_routes_specs      = each.value.policy_based_routes_specs
  skip_policy_based_routes_specs = each.value.skip_policy_based_routes_specs
}

############################# Cloud NAT ##############################
module "CloudNat" {
  source                   = "./modules/CloudNat"
  for_each                 = var.compute_router_nat_specs
  router_name              = "router-nat-${each.value.region}-prd-${each.value.name_index}"
  cloud_nat_name           = "nat-${each.value.region}-prd-${each.value.name_index}"
  project                  = var.project_ID
  region                   = each.value.region
  network_id               = module.networks["internet"].vpc.id
  compute_router_nat_specs = each.value
}


# ####################### FW VIRTUAL MACHINES ####################### 
# resource "google_compute_instance_template" "compute_instance_template_region_A" {
#   name_prefix    = "instance-template-region-a-001"
#   project        = var.project_ID
#   machine_type   = "n1-standard-4"
#   region         = "<Reg-A>"
#   can_ip_forward = true
#   tags           = [for i in module.tags : i.tag_key]

#   disk {
#     source_image = "https://www.googleapis.com/compute/beta/projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240731"
#     auto_delete  = true
#     boot         = true
#   }

#   network_interface {
#     network    = module.networks["internet"].vpc.id
#     subnetwork = module.networks["internet"].subnets["snet-internet-ams"].id
#     stack_type = "IPV4_ONLY"
#     # access_config {
#     #   network_tier = "PREMIUM"
#     # }
#   }

#   network_interface {
#     network    = module.networks["hub"].vpc.id
#     subnetwork = module.networks["hub"].subnets["snet-hub-ams"].id
#     stack_type = "IPV4_ONLY"
#     # access_config {
#     #   network_tier = "PREMIUM"
#     # }
#   }

#   network_interface {
#     network    = module.networks["hybrid"].vpc.id
#     subnetwork = module.networks["hybrid"].subnets["snet-hybrid-ams"].id
#     stack_type = "IPV4_ONLY"
#     # access_config {
#     #   network_tier = "PREMIUM"
#     # }
#   }

#   network_interface {
#     network    = module.networks["mgmt-ams"].vpc.id
#     subnetwork = module.networks["mgmt-ams"].subnets["snet-mgmt-ams"].id
#     stack_type = "IPV4_ONLY"
#     # access_config {
#     #   network_tier = "PREMIUM"
#     # }
#   }

#   lifecycle {
#     create_before_destroy = true
#   }

#   metadata = {
#     startup-script = <<-EOF1
#       #! /bin/bash
#       sudo sysctl -w net.ipv4.ip_forward=1
#       EOF
#     EOF1
#   }
# }

# resource "google_compute_instance_template" "compute_instance_template_region_B" {
#   name_prefix    = "instance-template-region-b-001"
#   project        = var.project_ID
#   machine_type   = "n1-standard-4"
#   region         = "<Reg-B>"
#   can_ip_forward = true
#   tags           = [for i in module.tags : i.tag_key]


#   disk {
#     source_image = "https://www.googleapis.com/compute/beta/projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240731"
#     auto_delete  = true
#     boot         = true
#   }

#   network_interface {
#     network    = module.networks["internet"].vpc.id
#     subnetwork = module.networks["internet"].subnets["snet-internet-fra"].id
#     stack_type = "IPV4_ONLY"
#     # access_config {
#     #   network_tier = "PREMIUM"
#     # }
#   }

#   network_interface {
#     network    = module.networks["hub"].vpc.id
#     subnetwork = module.networks["hub"].subnets["snet-hub-fra"].id
#     stack_type = "IPV4_ONLY"
#     # access_config {
#     #   network_tier = "PREMIUM"
#     # }
#   }

#   network_interface {
#     network    = module.networks["hybrid"].vpc.id
#     subnetwork = module.networks["hybrid"].subnets["snet-hybrid-fra"].id
#     stack_type = "IPV4_ONLY"
#     # access_config {
#     #   network_tier = "PREMIUM"
#     # }
#   }

#   network_interface {
#     network    = module.networks["mgmt-fra"].vpc.id
#     subnetwork = module.networks["mgmt-fra"].subnets["snet-mgmt-fra"].id
#     stack_type = "IPV4_ONLY"
#     # access_config {
#     #   network_tier = "PREMIUM"
#     # }
#   }
#   lifecycle {
#     create_before_destroy = true
#   }

#   metadata = {
#     startup-script = <<-EOF1
#       #! /bin/bash
#       sudo sysctl -w net.ipv4.ip_forward=1
#       EOF
#     EOF1
#   }
# }

# resource "google_compute_instance_group_manager" "compute_instance_group_manager_region_A" {
#   name               = "igmgr-hub-${var.abr_region_A}-prd-001"
#   project            = var.project_ID
#   base_instance_name = "igmgr-hub-${var.abr_region_A}-prd"
#   zone               = "${var.region_A}-a"
#   target_size        = "1"
#   version {
#     instance_template = google_compute_instance_template.compute_instance_template_region_A.id
#   }
# }

# resource "google_compute_instance_group_manager" "compute_instance_group_manager_region_B" {
#   name               = "igmgr-hub-${var.abr_region_B}-prd-001"
#   project            = var.project_ID
#   base_instance_name = "igmgr-hub-${var.abr_region_B}-prd"
#   zone               = "${var.region_B}-a"
#   target_size        = "1"
#   version {
#     instance_template = google_compute_instance_template.compute_instance_template_region_B.id
#   }
# }


# resource "google_compute_autoscaler" "compute_autoscaler_region_A" {
#   name    = "aslr-hub-${var.abr_region_A}-prd"
#   project = var.project_ID
#   target  = google_compute_instance_group_manager.compute_instance_group_manager_region_A.id
#   zone    = "${var.region_A}-a"

#   autoscaling_policy {
#     cooldown_period = 60

#     cpu_utilization {
#       predictive_method = "NONE"
#       target            = 0.6
#     }

#     max_replicas = 1
#     min_replicas = 1
#     mode         = "ONLY_SCALE_OUT"
#   }
# }

# resource "google_compute_autoscaler" "compute_autoscaler_region_B" {
#   name    = "aslr-hub-${var.abr_region_B}-prd"
#   project = var.project_ID
#   target  = google_compute_instance_group_manager.compute_instance_group_manager_region_B.id
#   zone    = "${var.region_B}-a"

#   autoscaling_policy {
#     cooldown_period = 60

#     cpu_utilization {
#       predictive_method = "NONE"
#       target            = 0.6
#     }

#     max_replicas = 1
#     min_replicas = 1
#     mode         = "ONLY_SCALE_OUT"
#   }
# }
