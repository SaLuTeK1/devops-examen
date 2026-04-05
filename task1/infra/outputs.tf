output "droplet_name" {
  value = digitalocean_droplet.this.name
}

output "droplet_ip" {
  value = digitalocean_droplet.this.ipv4_address
}

output "vpc_name" {
  value = digitalocean_vpc.this.name
}

output "firewall_name" {
  value = digitalocean_firewall.this.name
}

output "bucket_name" {
  value = digitalocean_spaces_bucket.this.name
}