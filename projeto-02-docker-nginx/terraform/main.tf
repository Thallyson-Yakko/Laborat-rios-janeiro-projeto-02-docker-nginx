# ============================================
# ROOT MODULE - CHAMA OS MÓDULOS
# ============================================

# Módulo VPC
module "vpc" {
  source = "./modules/vpc"
  
  project_id   = var.project_id
  region       = var.region
  environment  = var.environment
  network_name = "gke-network"
  subnet_name  = "gke-subnet"
}

# Módulo GKE
module "gke" {
  source = "./modules/gke"
  
  project_id   = var.project_id
  region       = var.region
  environment  = var.environment
  cluster_name = "react-nginx-cluster"
  
  # Usar outputs do módulo VPC
  network_name         = module.vpc.vpc_name
  subnet_name          = module.vpc.subnet_name
  pods_range_name      = module.vpc.pods_range_name
  services_range_name  = module.vpc.services_range_name
  
  # Depende da VPC estar criada
  depends_on = [module.vpc]
}

# Módulo Artifact Registry
module "artifact_registry" {
  source = "./modules/artifact-registry"
  
  project_id    = var.project_id
  region        = var.region
  repository_id = "react-nginx-repo"
}

# Módulo Helm Charts
module "helm_charts" {
  source = "./modules/helm-charts"
  
  grafana_password = var.grafana_password
  
  # Depende do GKE estar criado
  depends_on = [module.gke]
}
