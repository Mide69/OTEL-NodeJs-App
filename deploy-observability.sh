#!/bin/bash
echo "Deploying OpenTelemetry Observability Stack..."

echo
echo "1. Deploying OpenTelemetry Collector..."
kubectl apply -f otel-collector-config.yaml
kubectl apply -f otel-collector-deployment.yaml

echo
echo "2. Deploying Jaeger..."
kubectl apply -f jaeger-deployment.yaml

echo
echo "3. Deploying Prometheus..."
kubectl apply -f prometheus-deployment.yaml

echo
echo "4. Deploying Grafana..."
kubectl apply -f grafana-deployment.yaml

echo
echo "5. Deploying Mario Application..."
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

echo
echo "Waiting for pods to be ready..."
kubectl wait --for=condition=ready pod -l app=otel-collector --timeout=60s
kubectl wait --for=condition=ready pod -l app=jaeger --timeout=60s
kubectl wait --for=condition=ready pod -l app=prometheus --timeout=60s
kubectl wait --for=condition=ready pod -l app=grafana --timeout=60s
kubectl wait --for=condition=ready pod -l app=mario --timeout=60s

echo
echo "Deployment complete!"
echo
echo "Port-forward commands to access services:"
echo "Mario App: kubectl port-forward service/mario-service 8080:80"
echo "Jaeger UI: kubectl port-forward service/jaeger-ui 16686:16686"
echo "Prometheus: kubectl port-forward service/prometheus 9090:9090"
echo "Grafana: kubectl port-forward service/grafana 3000:3000"
echo "OTel Collector: kubectl port-forward service/otel-collector 4317:4317"
echo
echo "Access URLs after port-forwarding:"
echo "Mario App: http://localhost:8080"
echo "Jaeger UI: http://localhost:16686"
echo "Prometheus: http://localhost:9090"
echo "Grafana: http://localhost:3000 (admin/admin)"