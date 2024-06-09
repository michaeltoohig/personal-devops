variable "token" {
    description = "Linode API access token"
}

variable "label" {
  description = "Linode VPS label"
}

variable "image" {
  description = "Linode VPS image type"
}

variable "linode_region" {
  description = "Linode VPS region"
}

variable "linode_instance_type" {
  description = "Linode VPS type"
}

variable "root_ssh_pubkey" {
  description = "Public SSH keyfile for root account"
}
