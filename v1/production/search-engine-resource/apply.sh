#!/bin/bash

# Apply environment variable substitution
./apply_envsubst.sh

# Apply the Kubernetes resources
kubectl apply -k .
