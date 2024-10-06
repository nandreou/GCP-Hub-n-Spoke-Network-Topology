resource "google_tags_tag_key" "tags_tag_key" {
  parent      = "projects/${var.project}"
  short_name  = "fw-${var.tag_specs.vpc}-rule"
  description = "Firewall Tag Key - ${var.tag_specs.vpc}"
  purpose     = var.tag_specs.purpose
  purpose_data = {
    network = "${var.project}/${var.vpc_name}"
  }
}

resource "google_tags_tag_value" "tags_tag_value" {
  parent      = "tagKeys/${google_tags_tag_key.tags_tag_key.name}"
  short_name  = "fw-${var.tag_specs.vpc}-rule-value"
  description = "Firewall Tag Value - ${var.tag_specs.vpc}"
}