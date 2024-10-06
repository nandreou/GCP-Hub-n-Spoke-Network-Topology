output "vpc" {
  value = google_compute_network.compute_network
}

output "subnets" {
  value = google_compute_subnetwork.compute_subnetwork
}