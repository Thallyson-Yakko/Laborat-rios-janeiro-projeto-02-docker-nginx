variable "project_id" {
  description = "ID do projeto GCP"
  type        = string
  default     = "playground-s-11-f23c9032"
}

variable "region" {
  description = "Região GCP"
  type        = string
  default     = "us-central1"
}

variable "environment" {
  description = "Ambiente"
  type        = string
  default     = "hml"
}

#variable "grafana_password" {
#  description = "Senha do Grafana"
#  type        = string
#  sensitive   = true
#s
