# ============================================
# INPUTS DO MÓDULO HELM CHARTS
# ============================================

variable "grafana_password" {
  description = "Senha do admin do Grafana"
  type        = string
  sensitive   = true
}
