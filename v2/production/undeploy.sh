#!/bin/bash

# Undeploy Bao Application from Production Environment

set -e

echo "🗑️  Undeploying Bao Application from Production..."

# Strong confirmation prompt for production
echo "⚠️  WARNING: You are about to remove the PRODUCTION deployment!"
read -p "Type 'CONFIRM DELETE PRODUCTION' to proceed: " confirm
if [[ $confirm != "CONFIRM DELETE PRODUCTION" ]]; then
    echo "❌ Undeploy cancelled."
    exit 1
fi

# Set the correct namespace and release name
NAMESPACE="bao-production-env"
RELEASE_NAME="bao-application"

# Uninstall the release
echo "🔧 Uninstalling release '$RELEASE_NAME' from namespace '$NAMESPACE'..."
helm uninstall "$RELEASE_NAME" --namespace "$NAMESPACE" || echo "⚠️  Release may not exist"

echo "✅ Bao Application undeployed successfully from production!"

# Optional: Remove namespace (uncomment if needed)
# echo "🗑️  Removing namespace '$NAMESPACE'..."
# kubectl delete namespace "$NAMESPACE" --ignore-not-found=true
