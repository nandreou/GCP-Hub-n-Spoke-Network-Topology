variable "tags" {
  type = list(string)
}

variable "name" {
  type = string
}

variable "name_skip" {
  type = string
}

variable "project" {
  type = string
}

variable "network_id" {
  type = string
}

variable "next_hop_ilb_ip" {
  type = string
}

variable "policy_based_routes_specs" {
  type = object({
    priority = number
    filter = object({
      protocol_version = string
      ip_protocol      = string
      src_range        = string
      dest_range       = string
    })

  })
}

variable "skip_policy_based_routes_specs" {
  type = object({
    priority = number
    filter = object({
      protocol_version = string
      ip_protocol      = string
      src_range        = string
      dest_range       = string
    })
  })
}