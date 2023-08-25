#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

PROVIDER_ROUTE=$(kubectl get route provider -o yaml | yq '.metadata.uid' | tr -d '\n')
CA_CERT=$(kubectl get secret "route-$PROVIDER_ROUTE" -o yaml | yq '.data["ca.crt"]' | base64 -d)

ytt \
    --data-value provider.ca_cert="$CA_CERT" \
    -f "$SCRIPT_DIR/../config/provider-ca-cert.yaml" | kubectl apply -f -
