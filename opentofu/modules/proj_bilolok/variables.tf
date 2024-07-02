variable "token" {
  description = "Linode API access token"
}

variable "environment_name" {
  description = "Environment for the Ansible hosts file"
}

variable "domain" {
  description = "Domain for the project"
}

variable "create_dns_domain" {
  description = "If true, create new Linode domain, if false read existing Linode domain"
  type        = bool
  default     = false
}

variable "vps_public_ip" {
  description = "IP address of the Linode instance"
}

variable "vps_public_ipv6" {
  description = "IPv6 address of the Linode instance"
}
