variable "environment_name" {
  description = "Environment for the Ansible hosts file"
}

variable "host" {
  description = "IP address of target host"
}

variable "username" {
  description = "Username for primary user account"
}

variable "root_ssh_privkey" {
  description = "Private SSH keyfile for root account"
}

variable "user_ssh_privkey" {
  description = "Private SSH keyfile for user account"
}

variable "user_ssh_pubkey" {
  description = "Public SSH keyfile for user account"
}
