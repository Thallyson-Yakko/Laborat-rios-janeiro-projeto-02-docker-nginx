variable "project_id" {
  description = "ID do projeto GCP"
  type        = string
}

variable "region" {
  description = "Região GCP"
  type        = string
}

variable "repository_id" {
  description = "ID do repositório"
  type        = string
  default     = "react-nginx-repo"
}

variable "description" {
  description = "Descrição do repositório"
  type        = string
  default     = "Repositório de imagens Docker"
}