variable "name" {
  type = string
}

variable "project" {
  type = string
}

variable "network_id" {
  type = string
}

variable "vpn_specs" {
  type = object({
    region     = string
    stack_type = string
  })
}