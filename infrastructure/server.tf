resource "hcloud_server" "server" {
  name  = "server"
  image = "debian-12"

  server_type = "cx22" # 2 vCPU, 4GB RAM, 20GB SSD
  location    = "hel1" # Helsinki, Finland

  ssh_keys = [
    hcloud_ssh_key.ssh_key.id
  ]
}

output "server_ip" {
  value = hcloud_server.server.ipv4_address
}
