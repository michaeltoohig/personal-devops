resource "linode_domain" "domain" {
  count = var.create_dns_domain ? 1 : 0
  domain = var.domain
  soa_email = "hostmaster@${var.domain}"
  type = "master"
}

data "linode_domain" "domain" {
  count = var.create_dns_domain ? 0 : 1
  domain = var.domain
}

locals {
  domain_id = var.create_dns_domain ? linode_domain.domain[0].id : data.linode_domain.domain[0].id
  subdomain = var.environment_name == "production" ? "" : "${var.environment_name}."
}

resource "linode_domain_record" "root" {
  domain_id = local.domain_id
  name = "${local.subdomain}${var.domain}"
  record_type = "A"
  target = var.vps_public_ip
}

resource "linode_domain_record" "root-ipv6" {
  domain_id = local.domain_id
  name = "${local.subdomain}${var.domain}"
  record_type = "AAAA"
  target = var.vps_public_ipv6
}

resource "linode_domain_record" "domain-www" {
  domain_id = local.domain_id
  name = "www.${local.subdomain}${var.domain}"
  record_type = "A"
  target = var.vps_public_ip
}

resource "linode_domain_record" "domain-www-ipv6" {
  domain_id = local.domain_id
  name = "www.${local.subdomain}${var.domain}"
  record_type = "AAAA"
  target = var.vps_public_ipv6
}

resource "linode_domain_record" "domain-api" {
  domain_id = local.domain_id
  name = "api.${local.subdomain}${var.domain}"
  record_type = "A"
  target = var.vps_public_ip
}

resource "linode_domain_record" "domain-api-ipv6" {
  domain_id = local.domain_id
  name = "api.${local.subdomain}${var.domain}"
  record_type = "AAAA"
  target = var.vps_public_ipv6
}

resource "linode_domain_record" "domain-upload" {
  domain_id = local.domain_id
  name = "upload.${local.subdomain}${var.domain}"
  record_type = "A"
  target = var.vps_public_ip
}

resource "linode_domain_record" "domain-upload-ipv6" {
  domain_id = local.domain_id
  name = "upload.${local.subdomain}${var.domain}"
  record_type = "AAAA"
  target = var.vps_public_ipv6
}

resource "linode_domain_record" "domain-image" {
  domain_id = local.domain_id
  name = "image.${local.subdomain}${var.domain}"
  record_type = "A"
  target = var.vps_public_ip
}

resource "linode_domain_record" "domain-image-ipv6" {
  domain_id = local.domain_id
  name = "image.${local.subdomain}${var.domain}"
  record_type = "AAAA"
  target = var.vps_public_ipv6
}

resource "linode_domain_record" "domain-video" {
  domain_id = local.domain_id
  name = "video.${local.subdomain}${var.domain}"
  record_type = "A"
  target = var.vps_public_ip
}

resource "linode_domain_record" "domain-video-ipv6" {
  domain_id = local.domain_id
  name = "video.${local.subdomain}${var.domain}"
  record_type = "AAAA"
  target = var.vps_public_ipv6
}
