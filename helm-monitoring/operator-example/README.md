# Prometheus Operator Approach

This directory contains example configurations for deploying monitoring using the Prometheus Operator pattern, which is recommended for large-scale enterprise deployments.

## Overview

The Prometheus Operator provides Kubernetes native deployment and management of Prometheus and related monitoring components. The operator extends the Kubernetes API with custom resources:

- **Prometheus**: Defines a Prometheus deployment
- **ServiceMonitor**: Defines how services should be monitored
- **PodMonitor**: Defines how pods should be monitored
- **AlertmanagerConfig**: Defines alerting rules
- **PrometheusRule**: Defines recording and alerting rules

## Deployment

```bash
# Add the Prometheus community Helm repository
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Install the kube-prometheus-stack (includes Prometheus Operator)
helm install prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace \
  --values prometheus-operator-values.yaml
```

## Custom Resources

### ServiceMonitor Example

The `service-monitor.yaml` file shows how to create a ServiceMonitor for the VProfile application:

```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: vprofile-app
  namespace: monitoring
  labels:
    release: prometheus
spec:
  selector:
    matchLabels:
      app: vproapp
  namespaceSelector:
    matchNames:
      - default
  endpoints:
  - port: http
    path: /actuator/prometheus
    interval: 15s
```

Apply it with:

```bash
kubectl apply -f service-monitor.yaml
```

## Advantages of the Operator Pattern

1. **Declarative Configuration**: Define monitoring as Kubernetes resources
2. **Automatic Reconciliation**: Operator ensures the actual state matches the desired state
3. **Custom Resources**: Native Kubernetes way to extend functionality
4. **High Availability**: Built-in support for high availability configurations
5. **Seamless Upgrades**: Easier version management and upgrades

## When to Use the Operator Pattern

Consider using the Prometheus Operator when:

- You have a large-scale Kubernetes environment
- You need to monitor many services across multiple namespaces
- You require sophisticated alerting rules and configurations
- You want automated management of the monitoring stack
- You have multiple teams that need to define their own monitoring configurations