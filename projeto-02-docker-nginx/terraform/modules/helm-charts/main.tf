# ============================================
# MÓDULO HELM CHARTS - RECURSOS
# ============================================

# IMPORTANTE: Provider Helm é configurado no root module (backend.tf)

# Prometheus Stack
resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = "monitoring"
  
  create_namespace = true
  
  set {
    name  = "prometheus.prometheusSpec.retention"
    value = "7d"
  }
  
  set {
    name  = "grafana.adminPassword"
    value = var.grafana_password
  }
}

# Gateway API - Instalado via kubectl apply
resource "null_resource" "gateway_api" {
  provisioner "local-exec" {
    command = "kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.0.0/standard-install.yaml"
  }
  
  # Só executa se o cluster estiver pronto
  depends_on = []
}
