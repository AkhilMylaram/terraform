#!/bin/bash

# Create monitoring namespace with resource quotas
kubectl apply -f namespace.yaml

# Add Helm repositories
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

# Install Prometheus with production values
helm install prometheus prometheus-community/prometheus \
  --namespace monitoring \
  --values prometheus-values.yaml

# Install Grafana with production values
helm install grafana grafana/grafana \
  --namespace monitoring \
  --values grafana-values.yaml

# Get the Grafana admin password
echo "Grafana admin password:"
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

# Display access information
echo ""
echo "Prometheus can be accessed via port 80 on the following DNS name from within your cluster:"
echo "prometheus-server.monitoring.svc.cluster.local"
echo ""
echo "Grafana can be accessed via port 80 on the following DNS name from within your cluster:"
echo "grafana.monitoring.svc.cluster.local"
echo ""
echo "To access Grafana from outside the cluster, set up an Ingress or use port-forwarding:"
echo "kubectl port-forward -n monitoring svc/grafana 3000:80"
echo "Then access Grafana at: http://localhost:3000"