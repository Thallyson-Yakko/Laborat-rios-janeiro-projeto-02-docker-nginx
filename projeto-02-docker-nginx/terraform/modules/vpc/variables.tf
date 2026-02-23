variable "project_id" {
  description = "ID do projeto GCP"
  type        = string
}

variable "region" {
  description = "Região GCP"
  type        = string
}

variable "network_name" {
  description = "Nome da VPC"
  type        = string
  default     = "gke-network"
}

variable "subnet_name" {
  description = "Nome da subnet"
  type        = string
  default     = "gke-subnet"
}

variable "subnet_cidr" {
  description = "CIDR da subnet principal"
  type        = string
  default     = "10.0.0.0/24"
}

variable "pods_cidr" {
  description = "CIDR para pods"
  type        = string
  default     = "10.1.0.0/16"
}

variable "services_cidr" {
  description = "CIDR para services"
  type        = string
  default     = "10.2.0.0/16"
}

variable "environment" {
  description = "Ambiente (dev, staging, prod, hml)"
  type        = string
  default     = "hml"
}