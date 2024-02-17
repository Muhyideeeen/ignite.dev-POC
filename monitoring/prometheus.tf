provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

resource "helm_release" "kube_prometheus_stack" {
  name       = "kube-prometheus-stack"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kube-prometheus-stack"
  namespace  = "monitoring"
  version    = "56.1.0" 

  values = [
    file("${path.module}/values.yaml"),
  ]
}

variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  default     = "../kubeconfig"
}
