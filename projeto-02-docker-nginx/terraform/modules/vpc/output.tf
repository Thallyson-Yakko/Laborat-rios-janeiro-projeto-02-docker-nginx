output "vpc_id" {
  description = "ID da VPC"
  value       = google_compute_network.vpc.id
}

output "vpc_name" {
  description = "Nome da VPC"
  value       = google_compute_network.vpc.name
}

output "subnet_id" {
  description = "ID da subnet"
  value       = google_compute_subnetwork.subnet.id
}

output "subnet_name" {
  description = "Nome da subnet"
  value       = google_compute_subnetwork.subnet.name
}

output "pods_range_name" {
  description = "Nome do range de pods"
  value       = "pods"
}

output "services_range_name" {
  description = "Nome do range de services"
  value       = "services"
}