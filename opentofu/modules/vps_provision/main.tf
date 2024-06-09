resource "linode_instance" "instance" {
  label = var.label
  image = var.image
  region = var.linode_region
  type = var.linode_instance_type
  authorized_keys = ["${chomp(file(var.root_ssh_pubkey))}"]
}
