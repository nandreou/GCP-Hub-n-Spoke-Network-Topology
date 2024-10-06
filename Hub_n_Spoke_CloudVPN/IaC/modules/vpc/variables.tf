variable "vpc_abr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "project" {
  type = string
}

variable "vpc_specs" {
  type = object({
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
  })
}

