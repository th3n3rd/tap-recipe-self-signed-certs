# TAP recipe: Deal with self signed certificates

This repository is used as a playground to experiment with Tanzu Application Platform (TAP) and self-signed certificates
for workloads.

## TODOs

- [x] Setup two basic workloads, a consumer and a provider (for now independent)
- [x] Integrates consumer and provider
- [ ] Install a self-signed certificate for the provider
    - [x] Generate a new self-signed certificate an upgrade the provider workload from http to https
    - [ ] Update the consumer workload in order to trust the CA used for the self-signed certificate
