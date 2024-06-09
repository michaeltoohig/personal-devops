variable "linode_token" {
  description = "Linode API access token"
}

variable "username" {
  description = "Username for primary user account"
}

variable "root_ssh_pubkey" {
  description = "Public SSH keyfile for root account"
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
