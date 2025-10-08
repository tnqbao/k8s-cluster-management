#!/bin/bash

# Undeploy Bao Application from Staging Environment

set -e

echo "🗑️  Undeploying Bao Application from Staging..."

# Confirmation prompt
read -p "Are you sure you want to remove the staging deployment? (yes/no): " confirm
if [[ $confirm != "yes" ]]; then
    echo "Undeploy cancelled."
    exit 1
fi

# Set the correct namespace and release name
NAMESPACE="bao-staging-env"
RELEASE_NAME="bao-application"

# Uninstall the release
echo "Uninstalling release '$RELEASE_NAME' from namespace '$NAMESPACE'..."
helm uninstall "$RELEASE_NAME" --namespace "$NAMESPACE" || echo "⚠Release may not exist"

# Optionally remove the namespace (uncomment if needed)
# echo " Removing namespace '$NAMESPACE'..."
# kubectl delete namespace "$NAMESPACE" --ignore-not-found=true

echo "Bao Application undeployed successfully from staging!"
