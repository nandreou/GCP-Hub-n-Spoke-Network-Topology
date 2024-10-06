resource "google_compute_address" "compute_address" {
  name         = var.compute_address_name
  region       = var.region
  project      = var.project
  address_type = var.compute_address_specs.address_type
  purpose      = var.compute_address_specs.purpose
  subnetwork   = var.subnetwork_id
}

resource "google_compute_region_health_check" "compute_region_health_check" {
  name                = var.health_check_name
  project             = var.project
  region              = var.region
  check_interval_sec  = var.lb_health_check_specs.check_interval_sec
  healthy_threshold   = var.lb_health_check_specs.healthy_threshold
  timeout_sec         = var.lb_health_check_specs.timeout_sec
  unhealthy_threshold = var.lb_health_check_specs.unhealthy_threshold

  tcp_health_check {
    port         = var.lb_health_check_specs.tcp_health_check.port
    proxy_header = var.lb_health_check_specs.tcp_health_check.proxy_header
  }

  log_config {
    enable = true
  }
}

resource "google_compute_region_backend_service" "compute_region_backend_service" {
  provider                        = google-beta
  name                            = var.backend_service_name
  project                         = var.project
  region                          = var.region
  network                         = var.network_id
  protocol                        = var.lb_backend_specs.protocol
  session_affinity                = var.lb_backend_specs.session_affinity
  timeout_sec                     = var.lb_backend_specs.timeout_sec
  connection_draining_timeout_sec = var.lb_backend_specs.connection_draining_timeout_sec
  load_balancing_scheme           = var.lb_backend_specs.load_balancing_scheme

  health_checks = [
    google_compute_region_health_check.compute_region_health_check.id
  ]

  log_config {
    enable      = true
    sample_rate = 1
  }

  backend {
    group          = var.instance_group
    failover       = var.lb_backend_specs.backend.failover
    balancing_mode = var.lb_backend_specs.backend.balancing_mode
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
  name                  = var.forwarding_rule_name
  project               = var.project
  region                = var.region
  network               = var.network_id
  subnetwork            = var.subnetwork_id
  all_ports             = var.lb_forwarding_rule_specs.all_ports
  allow_global_access   = var.lb_forwarding_rule_specs.allow_global_access
  backend_service       = google_compute_region_backend_service.compute_region_backend_service.id
  ip_address            = google_compute_address.compute_address.address
  ip_protocol           = var.lb_forwarding_rule_specs.ip_protocol
  ip_version            = var.lb_forwarding_rule_specs.ip_version
  load_balancing_scheme = var.lb_forwarding_rule_specs.load_balancing_scheme
  network_tier          = var.lb_forwarding_rule_specs.network_tier
}

