# GitOps Introduction

GitOps is the practice of using Git and code as the source of all configuration.

## Setup

> [!NOTE]
> Is based on the Dev Container extension and it's dependencies being present and running.
> Some platform recommandation:
> - Windows: [Docker Desktop](https://www.docker.com/products/docker-desktop/)
> - MacOS: [OrbStack](https://orbstack.dev/)
> - Linux: [Docker Engine](https://docs.docker.com/engine/install/)

1. Clone the repo
2. Open using the devcontainer `View -> Command Palette` + `Dev Containers: Reopen in Container``
3. Boot into the development shell: `nix develop`

## Usage

**Get vendor credentials**:
1. Fetch an API key for Hetzner from the cloud console for a specific project
2. Update the secrets file with the key

    ```sh
    sops edit secrets.yaml
    ```

**Setup cryptographic identities**:

> [!NOTE]
> We are treating the generated identities very carfree here. Think of these here more as home printed passports than stable identities.
> Those requires quite a bit more backing authority as well as infrastructure to prop up.

1. Create a SSH key (or use a pre-existing one)

    ```sh
    ssh-keygen -t ed25519 -b 4096 -C "" -P "" -f ssh-identity
    ```
2. Update the [./infrastructure/ssh-key.tf](/infrastructure/ssh-key.tf) with the public key [./ssh-identity.pub](/ssh-identity.pub)

**Setup playground**:

> [!NOTE]
> We are working with minimally exposed secrets here (your Hetzner access token). Which requires us to wrap the Terraform commands in a SOPS invocation,
> ensuring the secrets are only available to the process. The generic form is:
> `sops exec-env secrets.yaml "some command"`
> You could decrypt the secrets and just not commit those files. But that tend to lead to accidents. Still there are options, you will have to decide what
> works best for any particular project.

1. Instantiate infrastructure

    ```sh
    sops exec-env secrets.yaml "terraform -chdir=inrfastructure apply"
    ````

2. SSH into the server (read ip-address from previous step, you can read it using `terraform output`)

    ```sh
    ssh -i ssh-identity root@<ip-address>
    ```
3. Fool around, spin it down, then up.

**Cleanup**:
```sh
sops exec-env secrets.yaml "terraform -chdir=infrastructure destroy"
```

## Workbench Overview

A short descript about each tool is inside [./docs/cheat-sheet/](/docs/cheat-sheet/). I advise using each tools inbuilt helper as well for quick reference `tofu --help`. For more details refer to each tools documentation site.

- [`nix`](https://nixos.org/): Declares which CLI tools and versions that are used in this project
- [`terraform`](https://developer.hashicorp.com/terraform): A commonly used tooling for provisioning and configuring external services
- [`tofu`](https://opentofu.org/): Alternative open source variant of Terraform, currently they are largely identical
- [`sops`](https://github.com/getsops/sops): Tool for managing secrets as part of a version controlled repository
- [`age-keygen`](https://github.com/FiloSottile/age): Modern tool for creating cryptographic keys, encrypting and decrypting encoded material
- [`ssh`](https://www.openssh.com/): Tool for managing machines through remmote shell

## External Services

- [GitHub](https://github.com/): A cloud provider delivering Version Control Systems, Collaboration platform, Identities, automated workers and binary storage repositories
- [Hetzner](https://www.hetzner.com/): A cheap, European, cloud provider delivering generic Compute, Network, and Storage Solutions

## Rational behind the tooling choice

<p float="left" align="middle">
  <img width="300" src="./docs/assets/workbench-organized.webp" alt="An organized workbench" />
  <img width="300" src="./docs/assets/workbench-disorganized.webp" alt="A messy garage" />
<p>

The bar aim to reach is the organized toolbench where all the tools we need for a specific project are laid out and outlined.
