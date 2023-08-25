#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

WORKLOAD="$SCRIPT_DIR/../config/consumer-workload.yaml"
INGRESS_DOMAIN=$(tanzu package installed get tap -n tap-install --values | yq '.shared.ingress_domain' | tr -d '\n')

kubectl delete workload consumer || true
ytt \
    --data-value namespace="apps" \
    --data-value ingress.domain="$INGRESS_DOMAIN" \
    -f "$WORKLOAD" | kubectl apply -f -

tanzu apps workload tail consumer
