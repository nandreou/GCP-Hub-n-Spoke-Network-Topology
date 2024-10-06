variable "project" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "tag_specs" {
  type = object({
    vpc     = string
    purpose = string
  })
}