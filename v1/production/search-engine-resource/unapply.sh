#!/bin/bash

# Delete the Kubernetes resources
kubectl delete -k .

# Clean up the generated base files
rm -rf base/
