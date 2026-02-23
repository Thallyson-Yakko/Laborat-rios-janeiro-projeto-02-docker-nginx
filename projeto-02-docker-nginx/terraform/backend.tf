# ============================================
# CONFIGURAÇÃO DO BACKEND E PROVIDERS
# ============================================

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
  
  # Backend GCS (opcional - comente se não criou bucket)
  backend "gcs" {
    bucket = "react-nginxterraform-state"
    prefix = "hml/terraform/state"
  }
}

# Provider Google
provider "google" {
  project = var.project_id
  region  = var.region
}

# Provider Helm (configurado após GKE estar criado)
provider "helm" {
  kubernetes {
    host                   = "https://${module.gke.cluster_endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(module.gke.cluster_ca_certificate)
  }
}

# Data source para autenticação
data "google_client_config" "default" {}
