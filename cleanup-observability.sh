#!/bin/bash
echo "Cleaning up OpenTelemetry Observability Stack..."

kubectl delete -f deployment.yaml
kubectl delete -f service.yaml
kubectl delete -f otel-collector-deployment.yaml
kubectl delete -f otel-collector-config.yaml
kubectl delete -f jaeger-deployment.yaml
kubectl delete -f prometheus-deployment.yaml
kubectl delete -f grafana-deployment.yaml

echo "Cleanup complete!"