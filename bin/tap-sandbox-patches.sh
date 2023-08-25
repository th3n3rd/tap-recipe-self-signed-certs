#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

TMP_FOLDER=$(mktemp -d)
trap "rm -rf $TMP_FOLDER" EXIT

kubectl apply -f "$SCRIPT_DIR/../config/untrusted-selfsigned-issuer.yaml"
TAP_INGRESS_ISSUER=$(tanzu package installed get tap -n tap-install --values | yq '.shared.ingress_issuer' | tr -d '\n')
if [[ ! "$TAP_INGRESS_ISSUER" =~ "untrusted-selfsigned-issuer" ]]; then
    echo "TAP should be configured to use the \"untrusted-selfsigned-issuer\" as certificates issuer, instead was $TAP_INGRESS_ISSUER"
    echo "Patching tap values"
    TAP_VERSION=$(tanzu package installed list -A -o yaml | yq '.[] | select (.name == "tap") | .package-version')
    TAP_VALUES_FILE="$TMP_FOLDER/tap-values.yaml"
    tanzu package installed get tap \
        -n tap-install \
        --values \
        | yq '.shared.ingress_issuer = "untrusted-selfsigned-issuer"' > "$TAP_VALUES_FILE"
    tanzu package installed update tap \
        -n tap-install \
        -p tap.tanzu.vmware.com \
        -v "$TAP_VERSION" \
        --values-file "$TAP_VALUES_FILE"
else
    echo "TAP is configured to use the \"untrusted-selfsigned-issuer\" as certificates issuer"
fi
