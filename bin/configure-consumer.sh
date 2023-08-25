#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

WORKLOAD="$SCRIPT_DIR/../consumer/config/workload.yaml"

kubectl delete -f "$WORKLOAD" || true
kubectl apply -f "$WORKLOAD"

tanzu apps workload get consumer
