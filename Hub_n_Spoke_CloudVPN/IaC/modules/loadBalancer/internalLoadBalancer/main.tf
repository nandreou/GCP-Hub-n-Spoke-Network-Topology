resource "google_compute_address" "compute_address" {
  name         = var.compute_address_name               #"ip-hub-${var.abr_region_A}-prd"
  region       = var.region                             #var.region_A
  project      = var.project                            #data.google_project.project.project_id
  address_type = var.compute_address_specs.address_type #"INTERNAL"
  purpose      = var.compute_address_specs.purpose      #"GCE_ENDPOINT"
  subnetwork   = var.subnetwork_id                      #google_compute_subnetwork.compute_subnetwork_region_A.id
}

resource "google_compute_region_health_check" "compute_region_health_check" {
  name                = var.health_check_name
  project             = var.project #data.google_project.project.project_id
  region              = var.region
  check_interval_sec  = var.lb_health_check_specs.check_interval_sec  #5
  healthy_threshold   = var.lb_health_check_specs.healthy_threshold   #2
  timeout_sec         = var.lb_health_check_specs.timeout_sec         #5
  unhealthy_threshold = var.lb_health_check_specs.unhealthy_threshold #2

  tcp_health_check {
    port         = var.lb_health_check_specs.tcp_health_check.port         #80
    proxy_header = var.lb_health_check_specs.tcp_health_check.proxy_header #"NONE"
  }

  log_config {
    enable = true
  }
}

resource "google_compute_region_backend_service" "compute_region_backend_service" {
  provider                        = google-beta
  name                            = var.backend_service_name #"ilb-hub-${var.abr_region_A}-prd"
  project                         = var.project              #data.google_project.project.project_id
  region                          = var.region
  network                         = var.network_id                                       #google_compute_network.compute_network.id
  protocol                        = var.lb_backend_specs.protocol                        #"TCP"
  session_affinity                = var.lb_backend_specs.session_affinity                #"NONE"
  timeout_sec                     = var.lb_backend_specs.timeout_sec                     #30
  connection_draining_timeout_sec = var.lb_backend_specs.connection_draining_timeout_sec #300
  load_balancing_scheme           = var.lb_backend_specs.load_balancing_scheme           #"INTERNAL"

  health_checks = [
    google_compute_region_health_check.compute_region_health_check.id
  ]

  log_config {
    enable      = true
    sample_rate = 1
  }

  backend {
    group          = var.instance_group                          #google_compute_region_instance_group_manager.mig.instance_group
    failover       = var.lb_backend_specs.backend.failover       #true
    balancing_mode = var.lb_backend_specs.backend.balancing_mode #"CONNECTION"
  }

  # connection_tracking_policy {
  #   tracking_mode                                = "PER_SESSION"
  #   connection_persistence_on_unhealthy_backends = "NEVER_PERSIST"
  #   idle_timeout_sec                             = 600
  # }

  # failover_policy {
  #   disable_connection_drain_on_failover = var.disable_connection_drain_on_failover
  #   drop_traffic_if_unhealthy            = var.drop_traffic_if_unhealthy
  #   failover_ratio                       = var.failover_ratio
  # }

  lifecycle {
    ignore_changes = [
      log_config
    ]
  }
}

resource "google_compute_forwarding_rule" "compute_forwarding_rule" {
  name                  = var.forwarding_rule_name #"fwdrule-hub-${var.abr_region_A}-prd"
  project               = var.project              #data.google_project.project.project_id
  region                = var.region
  network               = var.network_id                                   #google_compute_network.compute_network.id
  subnetwork            = var.subnetwork_id                                #google_compute_subnetwork.compute_subnetwork_region_A.id
  all_ports             = var.lb_forwarding_rule_specs.all_ports           #true
  allow_global_access   = var.lb_forwarding_rule_specs.allow_global_access #true
  backend_service       = google_compute_region_backend_service.compute_region_backend_service.id
  ip_address            = google_compute_address.compute_address.address
  ip_protocol           = var.lb_forwarding_rule_specs.ip_protocol           #"TCP"
  ip_version            = var.lb_forwarding_rule_specs.ip_version            #"IPV4"
  load_balancing_scheme = var.lb_forwarding_rule_specs.load_balancing_scheme #"INTERNAL"
  network_tier          = var.lb_forwarding_rule_specs.network_tier          #"PREMIUM"
}

