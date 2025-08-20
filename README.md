# OpenTelemetry Observability Stack for Kubernetes

A complete observability solution using OpenTelemetry Collector, Jaeger, and Prometheus to monitor applications in Kubernetes.

## 🏗️ Architecture

This repository deploys a comprehensive observability stack:
- **OpenTelemetry Collector**: Receives, processes, and exports telemetry data
- **Jaeger**: Distributed tracing backend for trace visualization
- **Prometheus**: Metrics collection and storage
- **Grafana**: Advanced dashboards and visualization for metrics
- **Sample Application**: Mario game app for demonstration

## 📋 Prerequisites

- Kubernetes cluster (1.20+)
- kubectl configured and connected to your cluster
- Basic understanding of Kubernetes concepts

## 🚀 Quick Start

### Deploy the Complete Stack

```bash
# Make deployment script executable
chmod +x deploy-observability.sh

# Deploy all components
./deploy-observability.sh
```

### Access the Services

After deployment, use port-forwarding to access the services:

```bash
# Mario Application
kubectl port-forward service/mario-service 8080:80

# Jaeger UI
kubectl port-forward service/jaeger-ui 16686:16686

# Prometheus
kubectl port-forward service/prometheus 9090:9090

# Grafana
kubectl port-forward service/grafana 3000:3000

# OpenTelemetry Collector
kubectl port-forward service/otel-collector 4317:4317
```

**Access URLs:**
- Mario App: http://localhost:8080
- Jaeger UI: http://localhost:16686
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000 (admin/admin)

## 📁 Repository Structure

```
otel-nodejs-app/
├── deployment.yaml              # Mario app deployment
├── service.yaml                 # Mario app service
├── otel-collector-config.yaml   # OTel Collector configuration
├── otel-collector-deployment.yaml # OTel Collector deployment
├── jaeger-deployment.yaml       # Jaeger all-in-one deployment
├── prometheus-deployment.yaml   # Prometheus deployment
├── grafana-deployment.yaml      # Grafana deployment with dashboards
├── deploy-observability.sh      # Automated deployment script
├── cleanup-observability.sh     # Cleanup script
└── script.sh                   # Environment setup script
```

## 🔧 Components

### OpenTelemetry Collector
- **Receivers**: OTLP (gRPC/HTTP), Prometheus scraping
- **Processors**: Batch processing
- **Exporters**: Jaeger for traces, Prometheus for metrics
- **Endpoints**: 
  - OTLP gRPC: `:4317`
  - OTLP HTTP: `:4318`
  - Metrics: `:8889`

### Jaeger
- All-in-one deployment with in-memory storage
- UI available on port `16686`
- Collector endpoint on port `14250`

### Prometheus
- Scrapes metrics from OTel Collector
- Web UI on port `9090`
- Configured to collect application metrics

### Grafana
- Advanced dashboards for metrics visualization
- Pre-configured with Prometheus datasource
- Web UI on port `3000` (admin/admin)
- Better alerting and dashboard capabilities

## 🛠️ Manual Deployment

If you prefer to deploy components individually:

```bash
# 1. Deploy OpenTelemetry Collector
kubectl apply -f otel-collector-config.yaml
kubectl apply -f otel-collector-deployment.yaml

# 2. Deploy Jaeger
kubectl apply -f jaeger-deployment.yaml

# 3. Deploy Prometheus
kubectl apply -f prometheus-deployment.yaml

# 4. Deploy Grafana
kubectl apply -f grafana-deployment.yaml

# 5. Deploy Sample Application
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

## 🧹 Cleanup

To remove all deployed resources:

```bash
# Make cleanup script executable
chmod +x cleanup-observability.sh

# Run cleanup
./cleanup-observability.sh
```

## 📊 Monitoring Your Applications

### For Node.js Applications

To instrument your Node.js application with OpenTelemetry:

1. **Install dependencies:**
```bash
npm install @opentelemetry/sdk-node @opentelemetry/auto-instrumentations-node @opentelemetry/exporter-otlp-http
```

2. **Create instrumentation file:**
```javascript
const { NodeSDK } = require('@opentelemetry/sdk-node');
const { getNodeAutoInstrumentations } = require('@opentelemetry/auto-instrumentations-node');
const { OTLPTraceExporter } = require('@opentelemetry/exporter-otlp-http');

const sdk = new NodeSDK({
  traceExporter: new OTLPTraceExporter({
    url: 'http://otel-collector:4318/v1/traces',
  }),
  instrumentations: [getNodeAutoInstrumentations()],
});

sdk.start();
```

3. **Import at the top of your main file:**
```javascript
require('./instrumentation');
// ... rest of your application
```

## 🔍 Troubleshooting

### Check Pod Status
```bash
kubectl get pods -l app=otel-collector
kubectl get pods -l app=jaeger
kubectl get pods -l app=prometheus
```

### View Logs
```bash
kubectl logs -l app=otel-collector
kubectl logs -l app=jaeger
```

### Verify Services
```bash
kubectl get services
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the deployment
5. Submit a pull request

## 📄 License

This project is licensed under the terms specified in the LICENSE file.

## 

Made with love by Johntoby
