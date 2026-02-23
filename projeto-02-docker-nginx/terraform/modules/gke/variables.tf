variable "project_id" {
  description = "ID do projeto GCP"
  type        = string
}

variable "region" {
  description = "Região GCP"
  type        = string
}

variable "cluster_name" {
  description = "Nome do cluster GKE"
  type        = string
}

variable "network_name" {
  description = "Nome da VPC"
  type        = string
}

variable "subnet_name" {
  description = "Nome da subnet"
  type        = string
}

variable "pods_range_name" {
  description = "Nome do range de pods"
  type        = string
  default     = "pods"
}

variable "services_range_name" {
  description = "Nome do range de services"
  type        = string
  default     = "services"
}

variable "node_count" {
  description = "Número de nodes"
  type        = number
  default     = 2
}

variable "machine_type" {
  description = "Tipo de máquina dos nodes"
  type        = string
  default     = "e2-medium"
}

variable "disk_size_gb" {
  description = "Tamanho do disco em GB"
  type        = number
  default     = 50
}

variable "environment" {
  description = "Ambiente (dev, staging, prod, hml)"
  type        = string
  default     = "hml"
}