# Production-Grade Prometheus and Grafana Monitoring

This directory contains Helm-based configurations for deploying a production-grade Prometheus and Grafana monitoring stack for the VProfile application.

## Architecture

The monitoring stack consists of:

- **Prometheus**: For metrics collection, storage, and alerting
  - Node Exporter: For hardware and OS metrics
  - Kube State Metrics: For Kubernetes object metrics
  - Alert Manager: For alert handling and notifications
  - Push Gateway: For batch job metrics

- **Grafana**: For metrics visualization and dashboarding
  - Pre-configured dashboards for VProfile application
  - Kubernetes cluster monitoring dashboard
  - Persistent storage for dashboards and configurations

## Prerequisites

- Kubernetes cluster (v1.16+)
- Helm 3.0+
- kubectl configured to communicate with your cluster
- Storage class available for persistent volumes

## Deployment

### 1. Create the monitoring namespace with resource quotas

```bash
kubectl apply -f namespace.yaml
```

### 2. Deploy Prometheus and Grafana using Helm

```bash
# Add required Helm repositories
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

# Install Prometheus
helm install prometheus prometheus-community/prometheus \
  --namespace monitoring \
  --values prometheus-values.yaml

# Install Grafana
helm install grafana grafana/grafana \
  --namespace monitoring \
  --values grafana-values.yaml
```

Alternatively, you can use the provided deployment script:

```bash
./deploy-monitoring.sh
```

## Accessing the Dashboards

### Prometheus

```bash
# Port-forward the Prometheus server
kubectl port-forward -n monitoring svc/prometheus-server 9090:80
```

Then access Prometheus at: http://localhost:9090

### Grafana

```bash
# Port-forward the Grafana service
kubectl port-forward -n monitoring svc/grafana 3000:80
```

Then access Grafana at: http://localhost:3000

Default credentials:
- Username: admin
- Password: admin (or retrieve from Kubernetes secret)

```bash
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

## Production Considerations

### High Availability

- Both Prometheus and Grafana are deployed with multiple replicas
- Pod anti-affinity ensures replicas run on different nodes
- Pod Disruption Budgets prevent unavailability during cluster operations

### Resource Management

- Resource requests and limits are defined for all components
- Namespace resource quotas prevent resource exhaustion

### Storage

- Persistent storage for Prometheus and Grafana
- Configurable retention period for metrics

### Security

- Ingress with TLS for secure access
- Grafana can be configured with SSO (commented in values file)

## Customization

### Prometheus

Edit `prometheus-values.yaml` to customize:
- Retention period
- Resource allocation
- Alert configurations
- Additional scrape targets

### Grafana

Edit `grafana-values.yaml` to customize:
- Dashboards
- Data sources
- Resource allocation
- Authentication methods

## Upgrading

```bash
# Update Prometheus
helm upgrade prometheus prometheus-community/prometheus \
  --namespace monitoring \
  --values prometheus-values.yaml

# Update Grafana
helm upgrade grafana grafana/grafana \
  --namespace monitoring \
  --values grafana-values.yaml
```

## Uninstalling

```bash
# Remove Grafana
helm uninstall grafana -n monitoring

# Remove Prometheus
helm uninstall prometheus -n monitoring

# Remove namespace and all resources
kubectl delete namespace monitoring
```