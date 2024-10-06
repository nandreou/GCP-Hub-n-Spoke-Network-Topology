# Create external IP addresses if non-specified
resource "google_compute_address" "compute_address_external" {
  name         = var.compute_address_name
  region       = var.region
  project      = var.project
  address_type = var.compute_address_specs.address_type #"EXTERNAL"
}

resource "google_compute_region_health_check" "compute_region_health_check_external" {
  name                = var.health_check_name
  project             = var.project #data.google_project.project.project_id
  region              = var.region
  check_interval_sec  = var.lb_health_check_specs.check_interval_sec  #5
  healthy_threshold   = var.lb_health_check_specs.healthy_threshold   #2
  timeout_sec         = var.lb_health_check_specs.timeout_sec         #5
  unhealthy_threshold = var.lb_health_check_specs.unhealthy_threshold #2

  http_health_check {
    port         = var.lb_health_check_specs.http_health_check.port         #80
    request_path = var.lb_health_check_specs.http_health_check.request_path #"/php/login.php"    
  }

  log_config {
    enable = true
  }
}

resource "google_compute_region_backend_service" "compute_region_backend_service_external" {
  provider                        = google-beta
  name                            = var.backend_service_name #"ilb-hub-${var.abr_region_A}-prd"
  project                         = var.project              #data.google_project.project.project_id
  region                          = var.region
  protocol                        = var.lb_backend_specs.protocol                        #"UNSPECIFIED"
  session_affinity                = var.lb_backend_specs.session_affinity                #"NONE"
  timeout_sec                     = var.lb_backend_specs.timeout_sec                     #30
  connection_draining_timeout_sec = var.lb_backend_specs.connection_draining_timeout_sec #300
  load_balancing_scheme           = var.lb_backend_specs.load_balancing_scheme           #"EXTERNAL"

  health_checks = [
    google_compute_region_health_check.compute_region_health_check_external.id
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
  name                  = var.forwarding_rule_name #"fwdrule-hub-${var.abr_region_A}-prd"
  project               = var.project              #data.google_project.project.project_id
  region                = var.region
  load_balancing_scheme = var.lb_forwarding_rule_specs.load_balancing_scheme #"EXTERNAL"
  ip_version            = var.lb_forwarding_rule_specs.ip_version            #"IPV4"
  all_ports             = var.lb_forwarding_rule_specs.all_ports             #true
  ip_address            = google_compute_address.compute_address_external.address
  ip_protocol           = var.lb_forwarding_rule_specs.ip_protocol #"L3_DEFAULT"
  backend_service       = google_compute_region_backend_service.compute_region_backend_service_external.self_link
  network_tier          = var.lb_forwarding_rule_specs.network_tier #"PREMIUM"
}
