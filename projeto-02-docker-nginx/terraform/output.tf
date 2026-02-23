output "vpc_id" {
  description = "ID da VPC"
  value       = module.vpc.vpc_id
}

output "cluster_name" {
  description = "Nome do cluster"
  value       = module.gke.cluster_name
}

output "kubectl_config" {
  description = "Comando para configurar kubectl"
  value       = "gcloud container clusters get-credentials ${module.gke.cluster_name} --region ${var.region} --project ${var.project_id}"
}

output "artifact_registry_url" {
  description = "URL do Artifact Registry"
  value       = module.artifact_registry.repository_url
}