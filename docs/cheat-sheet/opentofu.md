# OpenTofu

OpenTofu takes in a set of `.tf` files and access tokens to communicate with the APIs of a service provider to provision and configure your services.

In essence OpenTofu (or Terraform) is used as a way for us to describe what we have and how it's configured through code (hence Infrastructure as Code) allowing us to version control it and providing us a standardized pattern for ordering and configuring cloud resources. The alternatives are to do everything here using Web UIs and record our actions in some documentation system so the next person can understand what was done, a very error prone process.

## Example

`/some/directory/something.tf`
```tf
# Setting up the provider
terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.52.0"
    }
  }
}

provider "hcloud" {
  token = "this is a private password" # Don't commit this as is, use variables
}

# The service configuration/Requisition bill
resource "hcloud_server" "my_own_private_virtual_machine" {
  name     = "Cloudy"
  location = "hel1" # Hetzner's Helsinki datacenter
  type     = "ca21" # Hetzner's name for a 2 vCPU, 4GB RAM, 40GB SSD unit
  image    = "debian-12" # What OS to have preinstalled
}
```

**Then use the OpenTofu CLI to instantiate it**:
```sh
cd`/some/directory/something.tf`
tofu init
tofu apply
```

**Once done you can destroy all mentioned resources**
```sh
cd`/some/directory/something.tf`
tofu destroy
```

## OpenTofu vs Terraform

> [!NOTE]
> TLDR: Use one or the other it does not matter for small, short lived projects.

There are various licensing patterns employed by services so the developers behind them can restrict access and make money. The short of it is that Terraform started as an open source solution with tons of contributers adding to it and helping it evolve. Then HashiCorp (the company behind Terraform) made a change to the agreement to prevent even larger fish to eat them whole. Which pissed several of the contributors off, leaving us in this fragmented world.

OpenTofu is a fork, meaning that it and Terraform at one point was the same, with an Open Source license, while new versions of Terraform is not.
