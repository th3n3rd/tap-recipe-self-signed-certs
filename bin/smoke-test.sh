#!/bin/bash

set -e

echo "Running smoke tests"

CONSUMER_URL=$(kubectl get kservice consumer -o yaml | yq '.status.url' | tr -d '\n' )
CONSUMER_EXPECTED="{\"original\":\"Hello World!\",\"encoded\":\"SGVsbG8gV29ybGQh\"}"
CONSUMER_ACTUAL=$(curl --insecure -s -XGET "$CONSUMER_URL")
if [ "$CONSUMER_ACTUAL" != "$CONSUMER_EXPECTED" ]; then
    echo "Smoke test failed for consumer: expected \"$CONSUMER_EXPECTED\" but was \"$CONSUMER_ACTUAL\"" 1>&2
    exit 1
fi

PROVIDER_URL=$(kubectl get kservice provider -o yaml | yq '.status.url' | tr -d '\n' )
PROVIDER_EXPECTED="SGVsbG8gV29ybGQh"
PROVIDER_ACTUAL=$(curl --insecure -s -XPOST "$PROVIDER_URL" -H "Content-Type: application/json" -d "Hello World!")
if [ "$PROVIDER_ACTUAL" != "$PROVIDER_EXPECTED" ]; then
    echo "Smoke test failed for provider: expected \"$PROVIDER_EXPECTED\" but was \"$PROVIDER_ACTUAL\"" 1>&2
    exit 1
fi

echo "Smoke tests succeeded"
