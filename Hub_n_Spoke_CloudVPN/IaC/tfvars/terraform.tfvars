########################## VPC specs ##########################
vpc_specs = {
  "prd" : {
    name_index                                = "001"
    auto_create_subnetworks                   = false
    mtu                                       = 1460
    network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
    routing_mode                              = "GLOBAL"
    delete_default_routes_on_create           = true
    subnet_specs = {
      "snet-prd-reg-a" : {
        name_index                 = "001"
        region                     = "reg-a"
        ip_cidr_range              = "10.0.0.0/16"
        private_ip_google_access   = true
        private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
        purpose                    = "PRIVATE"
        stack_type                 = "IPV4_ONLY"

      },
      "snet-prd-reg-b" : {
        name_index                 = "001"
        region                     = "reg-b"
        ip_cidr_range              = "10.0.0.0/16"
        private_ip_google_access   = true
        private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
        purpose                    = "PRIVATE"
        stack_type                 = "IPV4_ONLY"

      }
    }

    #DON'T USE THESE FIREWALLS IN PRODUCTION OF LZ
    firewall_specs = {
      "fw-allow-all" : {
        direction     = "INGRESS"
        priority      = 100
        source_ranges = ["0.0.0.0/0"]
        allow = {
          protocol = "all"
        }
      }
    }
  }

  "staging" : {
    name_index                                = "001"
    auto_create_subnetworks                   = false
    mtu                                       = 1460
    network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
    routing_mode                              = "GLOBAL"
    delete_default_routes_on_create           = true
    subnet_specs = {
      "snet-staging-reg-a" : {
        name_index                 = "001"
        region                     = "reg-a"
        ip_cidr_range              = "10.0.0.0/16"
        private_ip_google_access   = true
        private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
        purpose                    = "PRIVATE"
        stack_type                 = "IPV4_ONLY"

      },
      "snet-staging-reg-b" : {
        name_index                 = "001"
        region                     = "reg-b"
        ip_cidr_range              = "10.0.0.0/16"
        private_ip_google_access   = true
        private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
        purpose                    = "PRIVATE"
        stack_type                 = "IPV4_ONLY"

      }
    }
    #DON'T USE THESE FIREWALLS IN PRODUCTION OF LZ
    firewall_specs = {
      "fw-allow-all" : {
        direction     = "INGRESS"
        priority      = 100
        source_ranges = ["0.0.0.0/0"]
        allow = {
          protocol = "all"
        }
      }
    }
  }

  "dev" : {
    name_index                                = "001"
    auto_create_subnetworks                   = false
    mtu                                       = 1460
    network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
    routing_mode                              = "GLOBAL"
    delete_default_routes_on_create           = true
    subnet_specs = {
      "snet-dev-reg-a" : {
        name_index                 = "001"
        region                     = "reg-a"
        ip_cidr_range              = "10.0.0.0/16"
        private_ip_google_access   = true
        private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
        purpose                    = "PRIVATE"
        stack_type                 = "IPV4_ONLY"

      },
      "snet-dev-reg-b" : {
        name_index                 = "001"
        region                     = "reg-b"
        ip_cidr_range              = "10.0.0.0/16"
        private_ip_google_access   = true
        private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
        purpose                    = "PRIVATE"
        stack_type                 = "IPV4_ONLY"

      }
    }
    #DON'T USE THESE FIREWALLS IN PRODUCTION OF LZ
    firewall_specs = {
      "fw-allow-all" : {
        direction     = "INGRESS"
        priority      = 100
        source_ranges = ["0.0.0.0/0"]
        allow = {
          protocol = "all"
        }
      }
    }
  }

  "internet" : {
    name_index                                = "001"
    auto_create_subnetworks                   = false
    mtu                                       = 1460
    network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
    routing_mode                              = "GLOBAL"
    delete_default_routes_on_create           = false
    subnet_specs = {
      "snet-internet-reg-a" : {
        name_index                 = "001"
        region                     = "reg-a"
        ip_cidr_range              = "10.0.0.0/16"
        private_ip_google_access   = true
        private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
        purpose                    = "PRIVATE"
        stack_type                 = "IPV4_ONLY"
      },
      "snet-internet-reg-a" : {
        name_index                 = "001"
        region                     = "reg-b"
        ip_cidr_range              = "10.0.0.0/16"
        private_ip_google_access   = true
        private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
        purpose                    = "PRIVATE"
        stack_type                 = "IPV4_ONLY"
      }
    }
    #DON'T USE THESE FIREWALLS IN PRODUCTION OF LZ
    firewall_specs = {
      "fw-allow-all" : {
        direction     = "INGRESS"
        priority      = 100
        source_ranges = ["0.0.0.0/0"]
        allow = {
          protocol = "all"
        }
      }
    }
  }

  "transit" : {
    name_index                                = "001"
    auto_create_subnetworks                   = false
    mtu                                       = 1460
    network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
    routing_mode                              = "GLOBAL"
    delete_default_routes_on_create           = true
    subnet_specs = {
      "snet-transit-reg-a" : {
        name_index                 = "001"
        region                     = "reg-a"
        ip_cidr_range              = "10.0.0.0/16"
        private_ip_google_access   = true
        private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
        purpose                    = "PRIVATE"
        stack_type                 = "IPV4_ONLY"
      },
      "snet-transit-reg-b" : {
        name_index                 = "001"
        region                     = "reg-b"
        ip_cidr_range              = "10.0.0.0/16"
        private_ip_google_access   = true
        private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
        purpose                    = "PRIVATE"
        stack_type                 = "IPV4_ONLY"
      }
    }
    #DON'T USE THESE FIREWALLS IN PRODUCTION OF LZ
    firewall_specs = {
      "fw-allow-all" : {
        direction     = "INGRESS"
        priority      = 100
        source_ranges = ["0.0.0.0/0"]
        allow = {
          protocol = "all"
        }
      }
    }
  }
}

tag_specs = {
  "fw-prd" : {
    vpc     = "prd"
    purpose = "GCE_FIREWALL"
  }

  "fw-staging" : {
    vpc     = "staging"
    purpose = "GCE_FIREWALL"
  }

  "fw-dev" : {
    vpc     = "dev"
    purpose = "GCE_FIREWALL"
  }

  "fw-internet" : {
    vpc     = "internet"
    purpose = "GCE_FIREWALL"
  }

  "fw-transit" : {
    vpc     = "transit"
    purpose = "GCE_FIREWALL"
  }
}

########################## LoadBalancerspecs ##########################
internal_load_balancer_specs = {
  //************ LB prd Reg-A ************//
  "lb-prd-reg-a" : {
    vpc         = "prd"
    subnet      = "snet-prd-reg-a"
    environment = "prd"
    region      = "reg-a"

    compute_address_specs = {
      name_index   = "001"
      address_type = "INTERNAL"
      purpose      = "GCE_ENDPOINT"
    }

    lb_health_check_specs = {
      name_index          = "001"
      check_interval_sec  = 5
      healthy_threshold   = 2
      timeout_sec         = 5
      unhealthy_threshold = 2
      tcp_health_check = {
        port         = 80
        proxy_header = "NONE"
      }
    }

    lb_backend_specs = {
      name_index                      = "001"
      protocol                        = "TCP"
      session_affinity                = "NONE"
      timeout_sec                     = 30
      connection_draining_timeout_sec = 300
      load_balancing_scheme           = "INTERNAL"
      backend = {
        failover       = false
        balancing_mode = "CONNECTION"
      }
    }

    lb_forwarding_rule_specs = {
      name_index            = "001"
      all_ports             = true
      allow_global_access   = true
      ip_protocol           = "TCP"
      ip_version            = "IPV4"
      load_balancing_scheme = "INTERNAL"
      network_tier          = "PREMIUM"
    }
  }

  //************ LB prd Reag-B ************//
  "lb-prd-reg-b" : {
    vpc         = "prd"
    subnet      = "snet-prd-reg-b"
    environment = "prd"
    region      = "reg-b"

    compute_address_specs = {
      name_index   = "001"
      address_type = "INTERNAL"
      purpose      = "GCE_ENDPOINT"
    }

    lb_health_check_specs = {
      name_index          = "001"
      check_interval_sec  = 5
      healthy_threshold   = 2
      timeout_sec         = 5
      unhealthy_threshold = 2
      tcp_health_check = {
        port         = 80
        proxy_header = "NONE"
      }
    }

    lb_backend_specs = {
      name_index                      = "001"
      protocol                        = "TCP"
      session_affinity                = "NONE"
      timeout_sec                     = 30
      connection_draining_timeout_sec = 300
      load_balancing_scheme           = "INTERNAL"
      backend = {
        failover       = false
        balancing_mode = "CONNECTION"
      }
    }

    lb_forwarding_rule_specs = {
      name_index            = "001"
      all_ports             = true
      allow_global_access   = true
      ip_protocol           = "TCP"
      ip_version            = "IPV4"
      load_balancing_scheme = "INTERNAL"
      network_tier          = "PREMIUM"
    }
  }

  //************ LB staging Reag-A ************//
  "lb-staging-reg-a" : {
    vpc         = "staging"
    subnet      = "snet-staging-reg-a"
    environment = "prd"
    region      = "reg-a"

    compute_address_specs = {
      name_index   = "001"
      address_type = "INTERNAL"
      purpose      = "GCE_ENDPOINT"
    }

    lb_health_check_specs = {
      name_index          = "001"
      check_interval_sec  = 5
      healthy_threshold   = 2
      timeout_sec         = 5
      unhealthy_threshold = 2
      tcp_health_check = {
        port         = 80
        proxy_header = "NONE"
      }
    }

    lb_backend_specs = {
      name_index                      = "001"
      protocol                        = "TCP"
      session_affinity                = "NONE"
      timeout_sec                     = 30
      connection_draining_timeout_sec = 300
      load_balancing_scheme           = "INTERNAL"
      backend = {
        failover       = false
        balancing_mode = "CONNECTION"
      }
    }

    lb_forwarding_rule_specs = {
      name_index            = "001"
      all_ports             = true
      allow_global_access   = true
      ip_protocol           = "TCP"
      ip_version            = "IPV4"
      load_balancing_scheme = "INTERNAL"
      network_tier          = "PREMIUM"
    }
  }

  //************ LB staging Reag-B ************//
  "lb-staging-reg-b" : {
    vpc         = "staging"
    subnet      = "snet-staging-reg-b"
    environment = "prd"
    region      = "reg-b"

    compute_address_specs = {
      name_index   = "001"
      address_type = "INTERNAL"
      purpose      = "GCE_ENDPOINT"
    }

    lb_health_check_specs = {
      name_index          = "001"
      check_interval_sec  = 5
      healthy_threshold   = 2
      timeout_sec         = 5
      unhealthy_threshold = 2
      tcp_health_check = {
        port         = 80
        proxy_header = "NONE"
      }
    }

    lb_backend_specs = {
      name_index                      = "001"
      protocol                        = "TCP"
      session_affinity                = "NONE"
      timeout_sec                     = 30
      connection_draining_timeout_sec = 300
      load_balancing_scheme           = "INTERNAL"
      backend = {
        failover       = false
        balancing_mode = "CONNECTION"
      }
    }

    lb_forwarding_rule_specs = {
      name_index            = "001"
      all_ports             = true
      allow_global_access   = true
      ip_protocol           = "TCP"
      ip_version            = "IPV4"
      load_balancing_scheme = "INTERNAL"
      network_tier          = "PREMIUM"
    }
  }

  //************ LB dev Reag-A ************//
  "lb-dev-reg-a" : {
    vpc         = "dev"
    subnet      = "snet-dev-reg-a"
    environment = "prd"
    region      = "reg-a"

    compute_address_specs = {
      name_index   = "001"
      address_type = "INTERNAL"
      purpose      = "GCE_ENDPOINT"
    }

    lb_health_check_specs = {
      name_index          = "001"
      check_interval_sec  = 5
      healthy_threshold   = 2
      timeout_sec         = 5
      unhealthy_threshold = 2
      tcp_health_check = {
        port         = 80
        proxy_header = "NONE"
      }
    }

    lb_backend_specs = {
      name_index                      = "001"
      protocol                        = "TCP"
      session_affinity                = "NONE"
      timeout_sec                     = 30
      connection_draining_timeout_sec = 300
      load_balancing_scheme           = "INTERNAL"
      backend = {
        failover       = false
        balancing_mode = "CONNECTION"
      }
    }

    lb_forwarding_rule_specs = {
      name_index            = "001"
      all_ports             = true
      allow_global_access   = true
      ip_protocol           = "TCP"
      ip_version            = "IPV4"
      load_balancing_scheme = "INTERNAL"
      network_tier          = "PREMIUM"
    }
  }

  //************ LB dev Reag-B ************//
  "lb-dev-reg-b" : {
    vpc         = "dev"
    subnet      = "snet-dev-reg-b"
    environment = "prd"
    region      = "reg-b"

    compute_address_specs = {
      name_index   = "001"
      address_type = "INTERNAL"
      purpose      = "GCE_ENDPOINT"
    }

    lb_health_check_specs = {
      name_index          = "001"
      check_interval_sec  = 5
      healthy_threshold   = 2
      timeout_sec         = 5
      unhealthy_threshold = 2
      tcp_health_check = {
        port         = 80
        proxy_header = "NONE"
      }
    }

    lb_backend_specs = {
      name_index                      = "001"
      protocol                        = "TCP"
      session_affinity                = "NONE"
      timeout_sec                     = 30
      connection_draining_timeout_sec = 300
      load_balancing_scheme           = "INTERNAL"
      backend = {
        failover       = false
        balancing_mode = "CONNECTION"
      }
    }

    lb_forwarding_rule_specs = {
      name_index            = "001"
      all_ports             = true
      allow_global_access   = true
      ip_protocol           = "TCP"
      ip_version            = "IPV4"
      load_balancing_scheme = "INTERNAL"
      network_tier          = "PREMIUM"
    }
  }

  //************ LB transit Reg-A ************//
  "lb-transit-reg-a" : {
    vpc         = "transit"
    subnet      = "snet-transit-reg-a"
    environment = "prd"
    region      = "reg-a"

    compute_address_specs = {
      name_index   = "001"
      address_type = "INTERNAL"
      purpose      = "GCE_ENDPOINT"
    }

    lb_health_check_specs = {
      name_index          = "001"
      check_interval_sec  = 5
      healthy_threshold   = 2
      timeout_sec         = 5
      unhealthy_threshold = 2
      tcp_health_check = {
        port         = 80
        proxy_header = "NONE"
      }
    }

    lb_backend_specs = {
      name_index                      = "001"
      protocol                        = "TCP"
      session_affinity                = "NONE"
      timeout_sec                     = 30
      connection_draining_timeout_sec = 300
      load_balancing_scheme           = "INTERNAL"
      backend = {
        failover       = false
        balancing_mode = "CONNECTION"
      }
    }

    lb_forwarding_rule_specs = {
      name_index            = "001"
      all_ports             = true
      allow_global_access   = true
      ip_protocol           = "TCP"
      ip_version            = "IPV4"
      load_balancing_scheme = "INTERNAL"
      network_tier          = "PREMIUM"
    }
  }

  //************ LB transit Reag-B ************//
  "lb-transit-reg-b" : {
    vpc         = "transit"
    subnet      = "snet-transit-reg-b"
    environment = "prd"
    region      = "reg-b"

    compute_address_specs = {
      name_index   = "001"
      address_type = "INTERNAL"
      purpose      = "GCE_ENDPOINT"
    }

    lb_health_check_specs = {
      name_index          = "001"
      check_interval_sec  = 5
      healthy_threshold   = 2
      timeout_sec         = 5
      unhealthy_threshold = 2
      tcp_health_check = {
        port         = 80
        proxy_header = "NONE"
      }
    }

    lb_backend_specs = {
      name_index                      = "001"
      protocol                        = "TCP"
      session_affinity                = "NONE"
      timeout_sec                     = 30
      connection_draining_timeout_sec = 300
      load_balancing_scheme           = "INTERNAL"
      backend = {
        failover       = false
        balancing_mode = "CONNECTION"
      }
    }

    lb_forwarding_rule_specs = {
      name_index            = "001"
      all_ports             = true
      allow_global_access   = true
      ip_protocol           = "TCP"
      ip_version            = "IPV4"
      load_balancing_scheme = "INTERNAL"
      network_tier          = "PREMIUM"
    }
  }
}


external_load_balancer_specs = {
  //************ LB Internet Reg-A ************//
  "lb-ext-internet-reg-a" : {
    environment = "prd"
    region      = "reg-a"

    compute_address_specs = {
      name_index   = "001"
      address_type = "EXTERNAL"
    }

    lb_health_check_specs = {
      name_index          = "001"
      check_interval_sec  = 5
      healthy_threshold   = 2
      timeout_sec         = 5
      unhealthy_threshold = 2
      http_health_check = {
        port         = 80
        request_path = "<YOUR_FW_HOME_URL_PATH_HERE>"
      }
    }

    lb_backend_specs = {
      name_index                      = "001"
      protocol                        = "UNSPECIFIED"
      session_affinity                = "NONE"
      timeout_sec                     = 30
      connection_draining_timeout_sec = 300
      load_balancing_scheme           = "EXTERNAL"
      backend = {
        failover       = false
        balancing_mode = "CONNECTION"
      }
    }

    lb_forwarding_rule_specs = {
      name_index            = "001"
      all_ports             = true
      ip_protocol           = "L3_DEFAULT"
      ip_version            = "IPV4"
      load_balancing_scheme = "EXTERNAL"
      network_tier          = "PREMIUM"
    }
  }

  //************ LB Internet Reag-B ************//
  "lb-ext-internet-reg-b" : {
    environment = "prd"
    region      = "reg-b"

    compute_address_specs = {
      name_index   = "001"
      address_type = "EXTERNAL"
    }

    lb_health_check_specs = {
      name_index          = "001"
      check_interval_sec  = 5
      healthy_threshold   = 2
      timeout_sec         = 5
      unhealthy_threshold = 2
      http_health_check = {
        port         = 80
        request_path = "<YOUR_FW_HOME_URL_PATH_HERE>"
      }
    }

    lb_backend_specs = {
      name_index                      = "001"
      protocol                        = "UNSPECIFIED"
      session_affinity                = "NONE"
      timeout_sec                     = 30
      connection_draining_timeout_sec = 300
      load_balancing_scheme           = "EXTERNAL"
      backend = {
        failover       = false
        balancing_mode = "CONNECTION"
      }
    }

    lb_forwarding_rule_specs = {
      name_index            = "001"
      all_ports             = true
      ip_protocol           = "L3_DEFAULT"
      ip_version            = "IPV4"
      load_balancing_scheme = "EXTERNAL"
      network_tier          = "PREMIUM"
    }
  }
}

########################## Policy Based Route specs ##########################
pbr_specs = {
  //************ PBR PRD REG A IN ************//  
  "pbr-prd-reg-a-in" : {
    vpc        = "prd"
    abr_region = "reg-a"

    policy_based_routes_specs = {
      load_balancer = "lb-prd-reg-a"
      priority      = 100
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "0.0.0.0/0"
        dest_range       = "10.0.0.0/16"
      }
    }

    skip_policy_based_routes_specs = {
      load_balancer = ""
      priority      = 10
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "0.0.0.0/0"
        dest_range       = "10.0.0.0/16"
      }
    }
  }

  //************ PBR PRD REG B IN ************//  
  "pbr-prd-reg-b-in" : {
    vpc        = "prd"
    abr_region = "reg-b"

    policy_based_routes_specs = {
      load_balancer = "lb-prd-reg-b"
      priority      = 100
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "0.0.0.0/0"
        dest_range       = "10.0.0.0/16"
      }
    }

    skip_policy_based_routes_specs = {
      load_balancer = ""
      priority      = 10
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "0.0.0.0/0"
        dest_range       = "10.0.0.0/16"
      }
    }
  }

  //************ PBR PRD REG A OUT ************//  
  "pbr-prd-reg-a-out" : {
    vpc        = "prd"
    abr_region = "reg-a"

    policy_based_routes_specs = {
      load_balancer = "lb-prd-reg-a"
      priority      = 200
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "10.0.0.0/16"
        dest_range       = "0.0.0.0/0"
      }
    }

    skip_policy_based_routes_specs = {
      load_balancer = ""
      priority      = 20
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "10.0.0.0/16"
        dest_range       = "0.0.0.0/0"
      }
    }
  }

  //************ PBR PRD REG B OUT ************//  
  "pbr-prd-reg-b-out" : {
    vpc        = "prd"
    abr_region = "reg-b"

    policy_based_routes_specs = {
      load_balancer = "lb-prd-reg-b"
      priority      = 200
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "10.0.0.0/16"
        dest_range       = "0.0.0.0/0"
      }
    }

    skip_policy_based_routes_specs = {
      load_balancer = ""
      priority      = 20
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "10.0.0.0/16"
        dest_range       = "0.0.0.0/0"
      }
    }
  }

  //************ PBR STAGING REG A IN ************//  
  "pbr-staging-reg-a-in" : {
    vpc        = "staging"
    abr_region = "reg-a"

    policy_based_routes_specs = {
      load_balancer = "lb-staging-reg-a"
      priority      = 100
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "0.0.0.0/0"
        dest_range       = "10.0.0.0/16"
      }
    }

    skip_policy_based_routes_specs = {
      load_balancer = ""
      priority      = 10
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "0.0.0.0/0"
        dest_range       = "10.0.0.0/16"
      }
    }
  }

  //************ PBR STAGING REG B IN ************//  
  "pbr-staging-reg-b-in" : {
    vpc        = "staging"
    abr_region = "reg-b"

    policy_based_routes_specs = {
      load_balancer = "lb-staging-reg-b"
      priority      = 100
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "0.0.0.0/0"
        dest_range       = "10.0.0.0/16"
      }
    }

    skip_policy_based_routes_specs = {
      load_balancer = ""
      priority      = 10
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "0.0.0.0/0"
        dest_range       = "10.0.0.0/16"
      }
    }
  }

  //************ PBR STAGING REG A OUT ************//  
  "pbr-staging-reg-a-out" : {
    vpc        = "staging"
    abr_region = "reg-a"

    policy_based_routes_specs = {
      load_balancer = "lb-staging-reg-a"
      priority      = 200
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "10.0.0.0/16"
        dest_range       = "0.0.0.0/0"
      }
    }

    skip_policy_based_routes_specs = {
      load_balancer = ""
      priority      = 20
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "10.0.0.0/16"
        dest_range       = "0.0.0.0/0"
      }
    }
  }

  //************ PBR STAGING REG B OUT ************//  
  "pbr-staging-reg-b-out" : {
    vpc        = "staging"
    abr_region = "reg-b"

    policy_based_routes_specs = {
      load_balancer = "lb-staging-reg-b"
      priority      = 200
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "10.0.0.0/16"
        dest_range       = "0.0.0.0/0"
      }
    }

    skip_policy_based_routes_specs = {
      load_balancer = ""
      priority      = 20
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "10.0.0.0/16"
        dest_range       = "0.0.0.0/0"
      }
    }
  }

  //************ PBR DEV REG A IN ************//  
  "pbr-dev-reg-a-in" : {
    vpc        = "prd"
    abr_region = "reg-a"

    policy_based_routes_specs = {
      load_balancer = "lb-dev-reg-a"
      priority      = 100
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "0.0.0.0/0"
        dest_range       = "10.0.0.0/16"
      }
    }

    skip_policy_based_routes_specs = {
      load_balancer = ""
      priority      = 10
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "0.0.0.0/0"
        dest_range       = "10.0.0.0/16"
      }
    }
  }

  //************ PBR PRD REG B IN ************//  
  "pbr-dev-reg-b-in" : {
    vpc        = "dev"
    abr_region = "reg-b"

    policy_based_routes_specs = {
      load_balancer = "lb-dev-reg-b"
      priority      = 100
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "0.0.0.0/0"
        dest_range       = "10.0.0.0/16"
      }
    }

    skip_policy_based_routes_specs = {
      load_balancer = ""
      priority      = 10
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "0.0.0.0/0"
        dest_range       = "10.0.0.0/16"
      }
    }
  }

  //************ PBR DEV REG A OUT ************//  
  "pbr-dev-reg-a-out" : {
    vpc        = "dev"
    abr_region = "reg-a"

    policy_based_routes_specs = {
      load_balancer = "lb-dev-reg-a"
      priority      = 200
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "10.0.0.0/16"
        dest_range       = "0.0.0.0/0"
      }
    }

    skip_policy_based_routes_specs = {
      load_balancer = ""
      priority      = 20
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "10.0.0.0/16"
        dest_range       = "0.0.0.0/0"
      }
    }
  }

  //************ PBR DEV REG B OUT ************//  
  "pbr-dev-reg-b-out" : {
    vpc        = "dev"
    abr_region = "reg-b"

    policy_based_routes_specs = {
      load_balancer = "lb-dev-reg-b"
      priority      = 200
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "10.0.0.0/16"
        dest_range       = "0.0.0.0/0"
      }
    }

    skip_policy_based_routes_specs = {
      load_balancer = ""
      priority      = 20
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "10.0.0.0/16"
        dest_range       = "0.0.0.0/0"
      }
    }
  }



  //************ PBR TRANSIT Reg-A ************//  
  "pbr-transit-reg-a" : {
    vpc        = "transit"
    abr_region = "reg-a"

    policy_based_routes_specs = {
      load_balancer = "lb-transit-reg-a"
      priority      = 100
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "0.0.0.0/0"
        dest_range       = "10.0.0.0/16"
      }
    }

    skip_policy_based_routes_specs = {
      load_balancer = ""
      priority      = 10
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "0.0.0.0/0"
        dest_range       = "10.0.0.0/16"
      }
    }
  }

  //************ PBR transit Reag-B ************//  
  "pbr-transit-reg-b" : {
    vpc        = "transit"
    abr_region = "reg-b"

    policy_based_routes_specs = {
      load_balancer = "lb-transit-reg-b"
      priority      = 100
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "0.0.0.0/0"
        dest_range       = "10.0.0.0/16"
      }
    }

    skip_policy_based_routes_specs = {
      load_balancer = ""
      priority      = 10
      filter = {
        protocol_version = "IPV4"
        ip_protocol      = "ALL"
        src_range        = "0.0.0.0/0"
        dest_range       = "10.0.0.0/16"
      }
    }
  }
}

########################## CloudNatspecs ##########################
compute_router_nat_specs = {
  "cloud-nat-reg-a" : {
    name_index                         = "001"
    region                             = "reg-a"
    nat_ip_allocate_option             = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  }
  "cloud-nat-reg-b" : {
    name_index                         = "001"
    region                             = "reg-b"
    nat_ip_allocate_option             = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  }
}


router_specs = {
  "router-prd-reg-a" : {
    vpc    = "prd"
    region = "reg-a"
    bgp = {
      advertise_mode     = "CUSTOM"
      asn                = 64512
      keepalive_interval = 30
      advertised_ip_ranges = {
        range = "0.0.0.0/0"

      }
    }
  }

  "router-prd-reg-b" : {
    vpc    = "prd"
    region = "reg-b"
    bgp = {
      advertise_mode     = "CUSTOM"
      asn                = 64512
      keepalive_interval = 30
      advertised_ip_ranges = {
        range = "0.0.0.0/0"

      }
    }
  }


  "router-staging-reg-a" : {
    vpc    = "staging"
    region = "reg-a"
    bgp = {
      advertise_mode     = "CUSTOM"
      asn                = 64512
      keepalive_interval = 30
      advertised_ip_ranges = {
        range = "0.0.0.0/0"

      }
    }
  }

  "router-staging-reg-b" : {
    vpc    = "staging"
    region = "reg-b"
    bgp = {
      advertise_mode     = "CUSTOM"
      asn                = 64512
      keepalive_interval = 30
      advertised_ip_ranges = {
        range = "0.0.0.0/0"

      }
    }
  }

  "router-dev-reg-a" : {
    vpc    = "dev"
    region = "reg-a"
    bgp = {
      advertise_mode     = "CUSTOM"
      asn                = 64512
      keepalive_interval = 30
      advertised_ip_ranges = {
        range = "0.0.0.0/0"

      }
    }
  }

  "router-dev-reg-b" : {
    vpc    = "dev"
    region = "reg-b"
    bgp = {
      advertise_mode     = "CUSTOM"
      asn                = 64512
      keepalive_interval = 30
      advertised_ip_ranges = {
        range = "0.0.0.0/0"

      }
    }
  }
}


vpn_specs = {
  "vpn-prd-reg-a" : {
    vpc        = "prd"
    region     = "reg-a"
    stack_type = "IPV4_ONLY"
  }

  "vpn-prd-reg-b" : {
    vpc        = "prd"
    region     = "reg-b"
    stack_type = "IPV4_ONLY"
  }

  "vpn-staging-reg-a" : {
    vpc        = "staging"
    region     = "reg-a"
    stack_type = "IPV4_ONLY"
  }

  "vpn-staging-reg-b" : {
    vpc        = "staging"
    region     = "reg-b"
    stack_type = "IPV4_ONLY"
  }

  "vpn-dev-reg-a" : {
    vpc        = "dev"
    region     = "reg-a"
    stack_type = "IPV4_ONLY"
  }

  "vpn-dev-reg-b" : {
    vpc        = "dev"
    region     = "reg-b"
    stack_type = "IPV4_ONLY"
  }
}