# VProfile Production Monitoring Stack

Enterprise-grade monitoring solution with full observability for VProfile application and Kubernetes infrastructure.

## Quick Deploy
```bash
./deploy.sh
```

## Access Points
- **Prometheus**: http://localhost:30900 - Metrics collection and querying
- **Grafana**: http://localhost:30300 (admin/admin123) - Dashboards and visualization
- **AlertManager**: http://localhost:30093 - Alert management and routing

using kind cluster
kubectl port-forward --address 0.0.0.0 service/prometheus-service 30900:9090 -n monitoring &
kubectl port-forward --address 0.0.0.0 service/grafana-service 30300:3000 -n monitoring &

format:
kubectl port-forward [resource] [LOCAL_PORT]:[POD_PORT]

access with above host and port  
http://localhost:30900 -- promitheus
http://localhost:30300 -- grafana

also you can configure this with default promitheus port 9090 to 80 and grafana

## Stack Components

### Core Monitoring
- **Prometheus**: Time-series database with PromQL querying
- **Grafana**: Interactive dashboards with real-time visualization
- **AlertManager**: Intelligent alert routing with deduplication

### Metrics Exporters
- **Node Exporter**: System-level metrics (CPU, memory, disk, network)
- **Kube State Metrics**: Kubernetes API object metrics
- **Application Metrics**: Custom VProfile application metrics

## Monitoring Coverage

### Infrastructure Monitoring
- **Node Health**: CPU usage, memory consumption, disk I/O, network traffic
- **Kubernetes Cluster**: Pod status, deployment health, service availability
- **Resource Utilization**: Container limits, requests, and actual usage

### Application Monitoring
- **Performance**: HTTP response times, request rates, error rates
- **Database**: MySQL connection pools, query performance, replication lag
- **Services**: RabbitMQ queue depth, Memcached hit rates, Elasticsearch health

### Alerting Rules
- High CPU/Memory usage (>80%)
- Pod restart loops or failures
- Database connection issues
- Application response time degradation
- Disk space warnings (<20% free)

## Directory Structure
```
monitoring/
├── prometheus/           # Prometheus server configuration
│   ├── configmap.yaml   # Scraping configuration
│   ├── deployment.yaml  # Prometheus deployment
│   └── service.yaml     # Service exposure
├── grafana/             # Grafana visualization
│   ├── configmap.yaml   # Datasource configuration
│   ├── deployment.yaml  # Grafana deployment
│   └── service.yaml     # Service exposure
├── alertmanager/        # Alert management
│   ├── configmap.yaml   # Alert routing rules
│   ├── deployment.yaml  # AlertManager deployment
│   └── service.yaml     # Service exposure
├── node-exporter/       # System metrics
│   └── daemonset.yaml   # Node exporter on all nodes
├── kube-state-metrics/  # Kubernetes metrics
│   ├── deployment.yaml  # KSM deployment
│   └── rbac.yaml        # Required permissions
├── configs/             # Dashboard configurations
│   └── dashboard.json   # VProfile dashboard
├── deploy.sh           # One-click deployment
└── README.md           # This file
```

## Deployment Steps
1. Ensure kubectl is configured for your cluster
2. Run `./deploy.sh` to deploy all components
3. Wait for all pods to be in Running state
4. Access dashboards via the URLs above

## Post-Deployment
- Import custom dashboards in Grafana
- Configure alert notification channels
- Set up alert rules based on your SLAs
- Monitor resource usage and scale as needed