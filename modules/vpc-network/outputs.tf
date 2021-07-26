output "network" {
  description = "A self link to VPC network"
  value       = google_compute_network.vpc_network.self_link
}