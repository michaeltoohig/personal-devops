variable "username" {
  description = "Namecheap username"
}

variable "token" {
  description = "Namecheap API access token"
}

variable "client_ip" {
  description = "Namecheap required public IP address of client (aka API of your machine accessing the API)"
}

variable "environment_name" {
  description = "Environment for the Ansible hosts file"
}

variable "subdomain" {
  description = "Subdomain for the project under my personal domain"
}

# variable "create_dns_domain" {
#   description = "If true, create new Linode domain, if false read existing Linode domain"
#   type        = bool
#   default     = false
# }

variable "vps_public_ip" {
  description = "IP address of the Linode instance"
}
