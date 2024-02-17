#!/bin/bash

kind create cluster --name test-cluster
export KUBECONFIG=$HOME/.kube/config

echo "Kubernetes cluster created successfully!"


