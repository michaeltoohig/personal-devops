data "terraform_remote_state" "global" {
  backend = "local"
  config = {
    path = "../global/terraform.tfstate"
  }
}

locals {
  environment_name = "development"
}

module "bilolok" {
  source = "../../../modules/proj_bilolok"
  token = "${var.linode_token}"

  environment_name = local.environment_name
  domain = var.domain
  create_dns_domain = false
  vps_public_ip = "${data.terraform_remote_state.global.outputs.vps_public_ip}"
  vps_public_ipv6 = split("/", "${data.terraform_remote_state.global.outputs.vps_public_ipv6}")[0]
}

