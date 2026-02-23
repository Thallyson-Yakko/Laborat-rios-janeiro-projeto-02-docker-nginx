output "prometheus_namespace" {
  description = "Namespace do Prometheus"
  value       = helm_release.prometheus.namespace
}

output "gateway_api_namespace" {
  description = "Namespace do Gateway API"
  value       = "gateway-system"
}