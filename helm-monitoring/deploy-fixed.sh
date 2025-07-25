#!/bin/bash

# Remove resource quota temporarily
kubectl delete resourcequota monitoring-quota -n monitoring

# Uninstall existing deployments
helm uninstall prometheus -n monitoring 2>/dev/null
helm uninstall grafana -n monitoring 2>/dev/null

# Wait for cleanup
sleep 10

# Install with complete resource specifications
helm install prometheus prometheus-community/prometheus \
  --namespace monitoring \
  --values prometheus-values-complete.yaml

helm install grafana grafana/grafana \
  --namespace monitoring \
  --values grafana-values-complete.yaml

echo "Deployment complete. Checking status..."
kubectl get pods -n monitoring