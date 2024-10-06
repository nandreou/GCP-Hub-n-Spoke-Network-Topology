# Create external IP addresses if non-specified
resource "google_compute_address" "compute_address_external" {
  name         = var.compute_address_name
  region       = var.region
  project      = var.project
  address_type = var.compute_address_specs.address_type
}

resource "google_compute_region_health_check" "compute_region_health_check_external" {
  name                = var.health_check_name
  project             = var.project
  region              = var.region
  check_interval_sec  = var.lb_health_check_specs.check_interval_sec
  healthy_threshold   = var.lb_health_check_specs.healthy_threshold
  timeout_sec         = var.lb_health_check_specs.timeout_sec
  unhealthy_threshold = var.lb_health_check_specs.unhealthy_threshold

  http_health_check {
    port         = var.lb_health_check_specs.http_health_check.port
    request_path = var.lb_health_check_specs.http_health_check.request_path
  }

  log_config {
    enable = true
  }
}

resource "google_compute_region_backend_service" "compute_region_backend_service_external" {
  provider                        = google-beta
  name                            = var.backend_service_name
  project                         = var.project
  region                          = var.region
  protocol                        = var.lb_backend_specs.protocol
  session_affinity                = var.lb_backend_specs.session_affinity
  timeout_sec                     = var.lb_backend_specs.timeout_sec
  connection_draining_timeout_sec = var.lb_backend_specs.connection_draining_timeout_sec
  load_balancing_scheme           = var.lb_backend_specs.load_balancing_scheme

  health_checks = [
    google_compute_region_health_check.compute_region_health_check_external.id
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

  #   connection_tracking_policy {
  #     tracking_mode                                = "PER_SESSION"
  #     connection_persistence_on_unhealthy_backends = "NEVER_PERSIST"
  #   }

  lifecycle {
    ignore_changes = [
      log_config
    ]
  }
}

resource "google_compute_forwarding_rule" "google_compute_forwarding_rule_external" {
  name                  = var.forwarding_rule_name
  project               = var.project
  region                = var.region
  load_balancing_scheme = var.lb_forwarding_rule_specs.load_balancing_scheme
  ip_version            = var.lb_forwarding_rule_specs.ip_version
  all_ports             = var.lb_forwarding_rule_specs.all_ports
  ip_address            = google_compute_address.compute_address_external.address
  ip_protocol           = var.lb_forwarding_rule_specs.ip_protocol
  backend_service       = google_compute_region_backend_service.compute_region_backend_service_external.self_link
  network_tier          = var.lb_forwarding_rule_specs.network_tier
}
