variable "name" {
  type = string
}

variable "project" {
  type = string
}

variable "network_id" {
  type = string
}

variable "router_specs" {
  type = object({
    region = string
    bgp = object({
      advertise_mode     = string
      asn                = string
      keepalive_interval = number
      advertised_ip_ranges = object({
        range = string
      })
    })
  })
}