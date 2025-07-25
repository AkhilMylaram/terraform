#!/bin/bash

echo "=== Checking AlertManager logs ==="
kubectl logs -n monitoring prometheus-alertmanager-0

echo "=== Checking Prometheus Server logs ==="
kubectl logs -n monitoring deployment/prometheus-server

echo "=== Checking Grafana logs ==="
kubectl logs -n monitoring deployment/grafana

echo "=== Checking Node Exporter logs ==="
kubectl logs -n monitoring daemonset/prometheus-prometheus-node-exporter

echo "=== Checking resource usage ==="
kubectl top pods -n monitoring