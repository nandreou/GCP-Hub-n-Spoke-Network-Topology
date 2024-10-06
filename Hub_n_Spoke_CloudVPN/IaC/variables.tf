variable "project_ID" {
  type    = string
  default = "SBX-002"
}

########################## VPC specs ##########################
variable "vpc_specs" {
  type = map(object({
    name_index                                = string
    auto_create_subnetworks                   = bool
    mtu                                       = number
    network_firewall_policy_enforcement_order = string
    routing_mode                              = string
    delete_default_routes_on_create           = bool

    subnet_specs = map(object({
      name_index                 = string
      region                     = string
      ip_cidr_range              = string
      private_ip_google_access   = bool
      private_ipv6_google_access = string
      purpose                    = string
      stack_type                 = string
    }))

    firewall_specs = map(object({
      direction     = string
      priority      = number
      source_ranges = set(string)
      allow = object({
        protocol = string
      })
    }))
  }))
}

variable "tag_specs" {
  type = map(object({
    vpc     = string
    purpose = string
  }))
}

########################## InternalLoadBalancerspecs ##########################
variable "internal_load_balancer_specs" {
  type = map(object({
    vpc         = string
    subnet      = string
    environment = string
    region      = string
    compute_address_specs = object({
      name_index   = string
      address_type = string
      purpose      = string
    })

    lb_health_check_specs = object({
      name_index          = string
      check_interval_sec  = number
      healthy_threshold   = number
      timeout_sec         = number
      unhealthy_threshold = number
      tcp_health_check = object({
        port         = number
        proxy_header = string
      })
    })

    lb_backend_specs = object({
      name_index                      = string
      protocol                        = string
      session_affinity                = string
      timeout_sec                     = number
      connection_draining_timeout_sec = number
      load_balancing_scheme           = string
      backend = object({
        failover       = bool
        balancing_mode = optional(string)
      })
    })

    lb_forwarding_rule_specs = object({
      name_index            = string
      all_ports             = bool
      allow_global_access   = bool
      ip_protocol           = string
      ip_version            = string
      load_balancing_scheme = string
      network_tier          = string
    })
  }))
}

########################## InternalLoadBalancerspecs ##########################
variable "external_load_balancer_specs" {
  type = map(object({
    environment = string
    region      = string
    compute_address_specs = object({
      name_index   = string
      address_type = string
    })

    lb_health_check_specs = object({
      name_index          = string
      check_interval_sec  = number
      healthy_threshold   = number
      timeout_sec         = number
      unhealthy_threshold = number
      http_health_check = object({
        port         = number
        request_path = string
      })
    })

    lb_backend_specs = object({
      name_index                      = string
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

    lb_forwarding_rule_specs = object({
      name_index            = string
      all_ports             = bool
      ip_protocol           = string
      ip_version            = string
      load_balancing_scheme = string
      network_tier          = string
    })
  }))
}

########################## PolicyBaseRoutesspecs ##########################
variable "pbr_specs" {
  type = map(object({
    vpc        = string
    abr_region = string

    policy_based_routes_specs = object({
      load_balancer = string
      priority      = number
      filter = object({
        protocol_version = string
        ip_protocol      = string
        src_range        = string
        dest_range       = string
      })

    })

    skip_policy_based_routes_specs = object({
      priority = number
      filter = object({
        protocol_version = string
        ip_protocol      = string
        src_range        = string
        dest_range       = string
      })
    })
  }))
}


########################## CloudNatspecs ##########################
variable "compute_router_nat_specs" {
  type = map(object({
    name_index                         = string
    region                             = string
    nat_ip_allocate_option             = string
    source_subnetwork_ip_ranges_to_nat = string
  }))
}

variable "vpn_specs" {
  type = map(object({
    vpc        = string
    region     = string
    stack_type = string
  }))
}

variable "router_specs" {
  type = map(object({
    vpc    = string
    region = string
    bgp = object({
      advertise_mode     = string
      asn                = string
      keepalive_interval = number
      advertised_ip_ranges = object({
        range = string
      })
    })
  }))
}

