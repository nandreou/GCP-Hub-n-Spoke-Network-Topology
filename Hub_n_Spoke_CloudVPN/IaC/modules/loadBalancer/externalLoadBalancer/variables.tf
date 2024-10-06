variable "compute_address_name" {
  type = string
}

variable "health_check_name" {
  type = string
}

variable "backend_service_name" {
  type = string
}

variable "forwarding_rule_name" {
  type = string
}

variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "instance_group" {
  type = string
}

variable "compute_address_specs" {
  type = object({
    address_type = string
  })
}

variable "lb_health_check_specs" {
  type = object({
    check_interval_sec  = number
    healthy_threshold   = number
    timeout_sec         = number
    unhealthy_threshold = number
    http_health_check = object({
      port         = number
      request_path = string
    })
  })
}

variable "lb_backend_specs" {
  type = object({
    protocol                        = string
    session_affinity                = string
    timeout_sec                     = number
    connection_draining_timeout_sec = number
    load_balancing_scheme           = string
    backend = object({
      failover       = bool
      balancing_mode = string
    })
  })
}

variable "lb_forwarding_rule_specs" {
  type = object({
    all_ports             = bool
    ip_protocol           = string
    ip_version            = string
    load_balancing_scheme = string
    network_tier          = string
  })
}