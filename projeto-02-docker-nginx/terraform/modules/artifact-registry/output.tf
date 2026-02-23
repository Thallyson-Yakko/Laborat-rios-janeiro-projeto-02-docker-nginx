output "repository_id" {
  description = "ID do repositório"
  value       = google_artifact_registry_repository.repo.repository_id
}

output "repository_url" {
  description = "URL do repositório"
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/${var.repository_id}"
}