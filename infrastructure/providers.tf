terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.52.0"
    }
  }
}

variable "hetzner_token" {
  description = "Hetzner API token"
  type        = string
  sensitive   = true
}

provider "hcloud" {
  token = var.hetzner_token
}
