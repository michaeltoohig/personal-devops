locals {
  environment_name = "production"
  label = "projects-01"
}

module "vps_provision" {
  source = "../../../modules/vps_provision"
  token = "${var.linode_token}"

  label = "${local.label}-vps"
  image = "linode/debian12"
  linode_region = "us-east"
  linode_instance_type = "g6-nanode-1"
  root_ssh_pubkey = "${var.root_ssh_pubkey}"
}

module "vps_setup" {
  source = "../../../modules/vps_setup"

  environment_name = "${local.environment_name}"
  host = "${module.vps_provision.vps_public_ip}"
  username = "${var.username}"
  root_ssh_privkey = "${var.root_ssh_privkey}"
  user_ssh_privkey = "${var.user_ssh_privkey}"
  user_ssh_pubkey = "${var.user_ssh_pubkey}"
}

module "vps_firewall" {
  source = "../../../modules/vps_firewall"
  token = "${var.linode_token}"

  label = "${local.label}-firewall"
  vps_instance_id = module.vps_provision.vps_instance_id
}
