#!/bin/bash

# Remove the problematic resource quota
kubectl delete resourcequota monitoring-quota -n monitoring

# Clean up existing deployments
helm uninstall prometheus -n monitoring 2>/dev/null
helm uninstall grafana -n monitoring 2>/dev/null

# Simple deployment without resource quotas
helm install prometheus prometheus-community/prometheus \
  --namespace monitoring \
  --set server.persistentVolume.size=3Gi \
  --set alertmanager.persistentVolume.size=1Gi \
  --set server.resources.requests.cpu=100m \
  --set server.resources.requests.memory=256Mi \
  --set server.resources.limits.cpu=300m \
  --set server.resources.limits.memory=512Mi

helm install grafana grafana/grafana \
  --namespace monitoring \
  --set persistence.size=1Gi \
  --set resources.requests.cpu=50m \
  --set resources.requests.memory=128Mi \
  --set resources.limits.cpu=200m \
  --set resources.limits.memory=256Mi

echo "Checking deployment status..."
kubectl get pods -n monitoring