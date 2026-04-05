variable "do_token" {
  type      = string
  sensitive = true
}

variable "spaces_access_key_id" {
  type      = string
  sensitive = true
}

variable "spaces_secret_access_key" {
  type      = string
  sensitive = true
}

variable "ssh_key_fingerprint" {
  type = string
}

variable "region" {
  type    = string
  default = "fra1"
}

variable "prefix" {
  type    = string
  default = "babiichuk"
}

variable "vpc_ip_range" {
  type    = string
  default = "10.10.10.0/24"
}

variable "droplet_size" {
  type    = string
  default = "s-2vcpu-4gb"
}

variable "droplet_image" {
  type    = string
  default = "ubuntu-24-04-x64"
}