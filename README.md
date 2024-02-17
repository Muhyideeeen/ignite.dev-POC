# Deploying kube-prometheus-stack with Terraform and Helm

This guide provides step-by-step instructions on deploying kube-prometheus-stack to your Kubernetes cluster using Terraform and Helm.

## Prerequisites

Before you begin, make sure you have the following prerequisites installed on your machine:

- [Terraform](https://www.terraform.io/downloads.html)
- [Helm](https://helm.sh/docs/intro/install/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- Docker (if you want to containerize and deploy your Node.js app)

## Clone the Repository

```bash
git clone https://github.com/your-username/your-repo.git
cd your-repo
```

## Set Up kubeconfig

Ensure that your `kubeconfig` file is in the correct directory. If needed, update the `kubeconfig_path` variable in `prometheus.tf`:

```hcl
variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  default     = "../../kubeconfig"  # Update this with the correct path if needed
}
```

## Customize Helm Values

Edit the `values.yaml` file to customize Helm values for kube-prometheus-stack deployment:

```yaml
# values.yaml

alertmanager:
  replicas: 1

grafana:
  enabled: true
```

## Deploy kube-prometheus-stack

```bash
terraform init
terraform apply
```

## Access Grafana

Retrieve the Grafana admin password:

```bash
kubectl get secret --namespace monitoring kube-prometheus-stack-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

Access Grafana using the service IP and port:

```bash
kubectl get svc --namespace monitoring kube-prometheus-stack-grafana
```

Open Grafana in your browser and log in using the admin password.

## Clean Up (Optional)

If needed, you can remove the kube-prometheus-stack deployment:

```bash
terraform destroy
```

Confirm with "yes" when prompted.

```

Remember to replace placeholders like `your-username`, `your-repo`, and adjust the paths accordingly based on your specific project structure.

Feel free to add more details or customize the guide based on your project's requirements. If you have additional components or configurations, include them in the guide for comprehensive instructions.
