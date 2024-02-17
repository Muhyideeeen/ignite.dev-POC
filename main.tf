provider "kubectl" {
  config_path = var.kubeconfig_path
}

resource "kubectl_manifest" "node_app_deployment" {
  yaml_body = file("${path.module}/express-deployment.yaml")
}

variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  default     ="kubeconfig"
}
