#!/bin/bash

# Deploy Bao Application to Staging Environment using Helm

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CHART_DIR="$SCRIPT_DIR/../bao-application"
ENV_CONFIG="$SCRIPT_DIR/.env"
VALUES_TEMPLATE="$CHART_DIR/values-staging.yaml"
VALUES_FILE="$SCRIPT_DIR/values-staging-processed.yaml"

echo "Deploying Bao Application to Staging..."

# Load environment variables from .env
if [ -f "$ENV_CONFIG" ]; then
    echo "📋 Loading environment variables from .env..."
    source "$ENV_CONFIG"
else
    echo "Environment configuration file not found at $ENV_CONFIG"
    exit 1
fi

# Check if Helm is installed
if ! command -v helm &> /dev/null; then
    echo "Helm is not installed. Please install Helm first."
    exit 1
fi

# Check if envsubst is available
if ! command -v envsubst &> /dev/null; then
    echo "envsubst is not available. Please install gettext package."
    exit 1
fi

# Process values file with environment variable substitution
echo "Processing values file with environment variables..."
envsubst < "$VALUES_TEMPLATE" > "$VALUES_FILE"

# Create namespace if it doesn't exist
NAMESPACE="bao-staging-env"
echo "Creating namespace $NAMESPACE if it doesn't exist..."
kubectl create namespace "$NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -

# Deploy using Helm
echo "Deploying with Helm..."
helm upgrade --install bao-application "$CHART_DIR" \
    --namespace "$NAMESPACE" \
    --values "$VALUES_FILE" \
    --timeout 10m \
    --wait

# Clean up processed values file
rm -f "$VALUES_FILE"

echo "Deployment completed successfully!"
echo "Check the deployment status with: kubectl get pods -n $NAMESPACE"
