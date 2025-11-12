#!/usr/bin/bash

set -e
kubectl --kubeconfig ../kubeconfig.yaml delete -k ./

