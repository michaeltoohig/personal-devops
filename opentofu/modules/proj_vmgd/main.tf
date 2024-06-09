locals {
  subsubdomain = var.environment_name == "production" ? "" : "${var.environment_name}."
}

resource "namecheap_domain_records" "vmgd-michaeltoohig-com" {
  domain = "michaeltoohig.com"
  mode = "MERGE"

  record {
    hostname = "${local.subsubdomain}${var.subdomain}"
    type = "A"
    address = "${var.vps_public_ip}"
  }
}
