#!/bin/bash

echo "Uninstalling existing deployments..."
helm uninstall prometheus -n monitoring
helm uninstall grafana -n monitoring

echo "Waiting for cleanup..."
sleep 30

echo "Reinstalling with fixed configurations..."

# Install Prometheus with fixed values
helm install prometheus prometheus-community/prometheus \
  --namespace monitoring \
  --values prometheus-values-fixed.yaml

# Install Grafana with fixed values
helm install grafana grafana/grafana \
  --namespace monitoring \
  --values grafana-values-fixed.yaml

echo "Deployment complete. Checking status..."
kubectl get pods -n monitoring