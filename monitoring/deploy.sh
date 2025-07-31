#!/bin/bash

echo "Deploying VProfile Monitoring Stack..."

# Create namespace
kubectl apply -f namespace.yaml

# Deploy Node Exporter
kubectl apply -f node-exporter/

# Deploy Kube State Metrics
kubectl apply -f kube-state-metrics/

# Deploy AlertManager
kubectl apply -f alertmanager/

# Deploy Prometheus
kubectl apply -f prometheus/

# Deploy Grafana
kubectl apply -f grafana/

echo "Monitoring stack deployed successfully!"
echo "Restarting Prometheus to reload configuration..."
kubectl rollout restart deployment/prometheus -n monitoring
echo "Access Prometheus at: http://localhost:30900"
echo "Access Grafana at: http://localhost:30300 (admin/admin123)"