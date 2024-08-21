data "terraform_remote_state" "global" {
  backend = "local"
  config = {
    path = "../global/terraform.tfstate"
  }
}

locals {
  environment_name = "production"
}

module "proj_vmgd" {
  source = "../../../modules/proj_vmgd"
  token = "${var.namecheap_token}"
  username = "${var.namecheap_username}"
  client_ip = "${var.namecheap_client_ip}"

  environment_name = "${local.environment_name}"
  subdomain = "${var.subdomain}"
  vps_public_ip = "${data.terraform_remote_state.global.outputs.vps_public_ip}"
}
