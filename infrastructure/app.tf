module "compose_app" {
  source = "./compose-app"

  # Server configuration
  server_type = "cx22" # 2 vCPU, 4GB RAM, 40GB SSD
  location    = "hel1" # Helsinki, Finland

  # Compose app configuration
  compose_app_repo   = "https://github.com/LarsGJobloop/nix-devcontainer-example.git"
  compose_app_branch = "compose-app"
  compose_app_path   = "compose.yaml"

  # Reconciliation configuration
  reconciliation_intervall = "1min"

  # SSH Key configuration
  # Provided here as this is for exploration and education purposes.
  # In production, we prefer to lock down servers and disable SSH access.
  ssh_key_id = hcloud_ssh_key.ssh_key.id
}

output "compose_app" {
  description = "The details of the compose app"
  value = {
    ipv4_address = module.compose_app.server_ip
  }
}

# Outputed for aiding with debugging
# Uncomment to see the rendered cloud-config for the server
# output "cloud_config" {
#   description = "The rendered cloud-config for the server"
#   value       = module.compose_app.cloud_config
# }
