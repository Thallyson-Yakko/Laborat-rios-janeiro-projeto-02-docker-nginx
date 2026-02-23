# VPC (Rede Virtual)
resource "google_compute_network" "vpc" {
  name                    = "${var.network_name}-${var.environment}"
  auto_create_subnetworks = false
  project                 = var.project_id
}

# Subnet com ranges secundários
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.subnet_name}-${var.environment}"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
  project       = var.project_id
  
  # Range para pods
  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = var.pods_cidr
  }
  
  # Range para services
  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = var.services_cidr
  }
  
  private_ip_google_access = true
}

# Cloud Router (necessário para NAT)
resource "google_compute_router" "router" {
  name    = "${var.network_name}-router-${var.environment}"
  region  = var.region
  network = google_compute_network.vpc.id
  project = var.project_id
}

# Cloud NAT (acesso internet para nodes privados)
resource "google_compute_router_nat" "nat" {
  name   = "${var.network_name}-nat-${var.environment}"
  router = google_compute_router.router.name
  region = var.region
  project = var.project_id
  
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}