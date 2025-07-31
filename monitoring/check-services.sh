#!/bin/bash

echo "Checking services in default namespace:"
kubectl get svc -n default

echo -e "\nChecking services in monitoring namespace:"
kubectl get svc -n monitoring

echo -e "\nApplying updated Prometheus config:"
kubectl apply -f prometheus/configmap.yaml

echo -e "\nRestarting Prometheus:"
kubectl rollout restart deployment/prometheus -n monitoring

echo -e "\nWaiting for Prometheus to be ready:"
kubectl rollout status deployment/prometheus -n monitoring

echo -e "\nDone! Check targets at http://localhost:30900/targets"