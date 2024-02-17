# Deploying Node.js Express App and Monitoring in Kubernetes Cluster

This guide provides step-by-step instructions on deploying a Node.js Express app to a Kubernetes cluster and setting up monitoring using kube-prometheus-stack.

## Prerequisites

Before you begin, make sure you have the following prerequisites installed on your machine:

- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- [Terraform](https://www.terraform.io/downloads.html)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install/)
- Docker (if you want to containerize and deploy your Node.js app)

## Clone the Repository

```bash
git clone https://github.com/Muhyideeeen/ignite.dev-POC
cd ignite.dev-POC
```

## Deploy Node.js Express App to Kubernetes Cluster

1. Run the kind_cluster.sh script to create a Kubernetes cluster using kind and download the kubeconfig file.

```bash
./kind_cluster.sh
```

2. Edit the `main.tf` file and change the `default` value of the `kubeconfig_path` variable to the path where you downloaded the kubeconfig file.

```hcl
variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  default     = "/path/to/your/kubeconfig"
}
```

3. Deploy the Express app on the kind cluster:

```bash
terraform init
terraform apply
```

Select "yes" when prompted.

4. Access the deployed app at `http://serverIP:8080`.

## Set Up Monitoring with kube-prometheus-stack

1. Navigate to the monitoring directory:

```bash
cd monitoring
```

2. Edit the `prometheus.tf` file and change the `default` value of the `kubeconfig_path` variable to the path where you downloaded the kubeconfig file.

```hcl
variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  default     = "/path/to/your/kubeconfig"
}
```

3. Update the `values.yaml` file to set the Grafana admin password as an empty string and define the Grafana service port. By default the port 

```yaml
# values.yaml

prometheus-operator:
  createCustomResource: false

kubelet:
  monitorWithoutCredentials: true

grafana:
  enabled: true
  adminPassword: ""
  service:
    type: ClusterIP
    port: 3000  # Set the desired port
```

4. Deploy kube-prometheus-stack for monitoring:

```bash
terraform init
terraform apply
```

Select "yes" when prompted.

## Accessing Grafana

Retrieve the Grafana admin password:

```bash
kubectl get secret --namespace monitoring kube-prometheus-stack-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

Access Grafana using the service IP and port. Retrieve the service IP:

```bash
kubectl get svc --namespace monitoring kube-prometheus-stack-grafana
```

Open Grafana in your browser using the provided IP and port, for example:

```
http://<grafana-service-IP>:<grafana-service-port>
```

Log in to Grafana using the admin password.

These steps should guide you through deploying the Node.js Express app, setting up monitoring with kube-prometheus-stack, and accessing both the deployed app and Grafana for monitoring. Adjust paths and values based on your specific project structure and configurations.
```
