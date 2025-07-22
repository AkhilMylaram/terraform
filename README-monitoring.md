# Monitoring Implementation for VProfile Project

This repository contains a production-grade implementation of Prometheus and Grafana for monitoring the VProfile application.

## Directory Structure

- **helm-monitoring/** - Production-grade Helm-based monitoring implementation
  - `prometheus-values.yaml` - Prometheus Helm chart values
  - `grafana-values.yaml` - Grafana Helm chart values
  - `namespace.yaml` - Monitoring namespace with resource quotas
  - `deploy-monitoring.sh` - Deployment script
  - `README.md` - Detailed documentation
  - **operator-example/** - Example configuration for Prometheus Operator approach

- **docs/** - Documentation and implementation guides
  - `monitoring-implementation.md` - Comprehensive guide on monitoring approaches

## Implementation Approaches

We've implemented monitoring using the Helm charts approach, which is recommended for production environments. The implementation includes:

1. **Prometheus** for metrics collection and storage
   - High availability with multiple replicas
   - Persistent storage for metrics
   - Resource limits and requests
   - Node Exporter for hardware metrics
   - Kube State Metrics for Kubernetes object metrics

2. **Grafana** for visualization
   - Pre-configured dashboards for application and Kubernetes metrics
   - Persistent storage for dashboards and configurations
   - High availability with multiple replicas
   - Ingress configuration for secure access

## Getting Started

### Prerequisites

- Kubernetes cluster (v1.16+)
- Helm 3.0+
- kubectl configured to communicate with your cluster

### Deployment

1. Navigate to the helm-monitoring directory:
   ```bash
   cd helm-monitoring
   ```

2. Run the deployment script:
   ```bash
   ./deploy-monitoring.sh
   ```

   Or deploy manually:
   ```bash
   # Create namespace with resource quotas
   kubectl apply -f namespace.yaml

   # Add Helm repositories
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

3. Access the dashboards:
   - Prometheus: `kubectl port-forward -n monitoring svc/prometheus-server 9090:80`
   - Grafana: `kubectl port-forward -n monitoring svc/grafana 3000:80`

## Documentation

For detailed information about the monitoring implementation, refer to:

- [Monitoring Implementation Guide](docs/monitoring-implementation.md)
- [Helm Monitoring README](helm-monitoring/README.md)

## Customization

To customize the monitoring setup:

1. Edit the values files:
   - `helm-monitoring/prometheus-values.yaml`
   - `helm-monitoring/grafana-values.yaml`

2. Update the deployment:
   ```bash
   helm upgrade prometheus prometheus-community/prometheus \
     --namespace monitoring \
     --values prometheus-values.yaml

   helm upgrade grafana grafana/grafana \
     --namespace monitoring \
     --values grafana-values.yaml
   ```

## Advanced: Operator Pattern

For large-scale enterprise deployments, consider the Prometheus Operator pattern. Example configurations are provided in the `helm-monitoring/operator-example/` directory.