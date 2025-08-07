# GitOps Introduction

GitOps is the practice of using Git and code as the source of all configuration.

## Tooling Overview

- [Nix](https://nixos.org/): Declares which CLI tools and versions that are used in this project
- [Terraform](https://developer.hashicorp.com/terraform): A commonly used tooling for provisioning and configuring external services
- [OpenTofu](https://opentofu.org/): Alternative open source variant of Terraform, currently they are largely identical
- [SOPS](https://github.com/getsops/sops): Tool for managing secrets as part of a version controlled repository
- [Age](https://github.com/FiloSottile/age): Modern tool for creating cryptographic keys, encrypting and decrypting encoded material
- [OpenSSH](https://www.openssh.com/): Tool for managing machines through remmote shell

## External Services

- [GitHub](https://github.com/): A cloud provider delivering Version Control Systems, Collaboration platform, Identities, automated workers and binary storage repositories
- [Hetzner](https://www.hetzner.com/): A cheap, European, cloud provider delivering generic Compute, Network, and Storage Solutions
